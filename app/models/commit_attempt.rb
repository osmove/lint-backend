# app/models/commit_attempt.rb
class CommitAttempt < ApplicationRecord

  belongs_to :commit, optional: true
  belongs_to :user, optional: true
  belongs_to :contributor, optional: true
  belongs_to :push, optional: true
  belongs_to :device, optional: true
  belongs_to :repository, optional: true
  has_many :policy_checks

  def to_s
    self.name
  end

  def name
    if self.message.present?
      @name = self.message
    else
      @name = "Commit Attempt ##{self.id}"
    end
    @name
  end


  after_update :send_report
  def send_report
    if message_changed?
      UserMailer.commit_attempt_report(self).deliver_later
      # UserMailer.commit_attempt_report(self).deliver_now
    end
  end

  # Create Commit with common attributes
  # after_update :create_commit
  # def create_commit
  #   if !self.commit.present?
  #     if self.sha.present? && !Commit.where(sha: self.sha).where(message: self.message).first.present?
  #       new_commit = Commit.create(self.attributes.select{ |key, _| Commit.attribute_names.include? key })
  #       self.commit = new_commit
  #     end
  #   end
  # end

  # Update Encryption From Repository
  before_create :update_encryption_from_repository
  def update_encryption_from_repository
    self.has_encryption = self.repository.has_encryption
    self.has_autofix = self.repository.has_autofix
    self.has_lint = self.repository.policy.present?
  end


  # Clean branch name
  before_save :clean_branch_name
  def clean_branch_name
    if self.branch_name.present?
      self.branch_name = self.branch_name.gsub(/[^a-zA-Z0-9\-]/,"")
    end
  end




end
