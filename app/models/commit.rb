class Commit < ApplicationRecord
  belongs_to :repository, touch: true
  belongs_to :user, optional: true
  belongs_to :contributor, optional: true
  belongs_to :push, optional: true
  # has_many :changes, :dependent => :destroy
  has_many :commit_attempts

  # Update Encryption From Repository
  before_create :update_encryption_from_repository

  after_create :assign_previous_commit_attempts
  def assign_previous_commit_attempts
    # Get one commit before the last one
    return if user.blank?

    last_user_commit = user.commits.order(id: :desc).limit(2).last
    return unless last_user_commit

    previous_attempts = CommitAttempt.where(user_id: user).where(repository: repository).where(commit_id: nil).where(
      'created_at > ?', last_user_commit.created_at
    )
    self.commit_attempts = previous_attempts
  end

  def update_encryption_from_repository
    self.has_encryption = repository.has_encryption
    self.has_autofix = repository.has_autofix
    self.has_lint = repository.policy.present?
  end
end
