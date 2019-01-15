class PolicyCheck < ApplicationRecord
  has_many :rule_checks, foreign_key: 'policy_check_id', :dependent => :destroy
  accepts_nested_attributes_for :rule_checks
  belongs_to :commit_attempt, optional: true, touch: true
  belongs_to :policy, optional: true
  belongs_to :repository, optional: true
  belongs_to :user, optional: true
  belongs_to :contributor, optional: true
  belongs_to :push, optional: true
  belongs_to :device, optional: true



  # after_create :send_report
  # def send_report
  #   UserMailer.commit_attempt_report(self).deliver_now
  # end

  after_create :copy_status_to_commit_attempt
  def copy_status_to_commit_attempt
    if self.commit_attempt.present?
      self.commit_attempt.passed = self.passed
    end
  end

  after_create :set_offense_count, :set_fixable_offense_count
  serialize :report, JSON

  def set_offense_count
    self.offense_count = 0
    if self.error_count.present?
      self.offense_count = self.offense_count + self.error_count
    end
    if self.warning_count.present?
      self.offense_count = self.offense_count + self.warning_count
    end
    self.offense_count
  end


  def set_fixable_offense_count
    self.fixable_offense_count = 0
    if self.fixable_error_count.present?
      self.fixable_offense_count = self.fixable_offense_count + self.fixable_error_count
    end
    if self.fixable_warning_count.present?
      self.fixable_offense_count = self.fixable_offense_count + self.fixable_warning_count
    end
    self.fixable_offense_count
  end

  def to_s
    if self.policy.present?
      self.policy.name
    end
  end

end
