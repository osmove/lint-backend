class PolicyCheck < ApplicationRecord
  has_many :rule_checks, dependent: :destroy
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

  # Update parent commit attempt passed or failed status
  after_create :copy_status_to_commit_attempt
  def copy_status_to_commit_attempt
    return unless commit_attempt.present?

    commit_attempt.update(passed: passed)
  end

  after_create :set_offense_count, :set_fixable_offense_count

  def set_offense_count
    self.offense_count = 0
    self.offense_count = offense_count + error_count if error_count.present?
    self.offense_count = offense_count + warning_count if warning_count.present?
    offense_count
  end

  def set_fixable_offense_count
    self.fixable_offense_count = 0
    self.fixable_offense_count = fixable_offense_count + fixable_error_count if fixable_error_count.present?
    self.fixable_offense_count = fixable_offense_count + fixable_warning_count if fixable_warning_count.present?
    fixable_offense_count
  end

  def to_s
    return unless policy.present?

    policy.name
  end
end
