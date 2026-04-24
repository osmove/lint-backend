class RuleCheck < ApplicationRecord
  belongs_to :language, optional: true
  belongs_to :rule, optional: true
  belongs_to :policy_check, optional: true
  belongs_to :repository, optional: true
  belongs_to :user, optional: true
  belongs_to :contributor, optional: true
  belongs_to :push, optional: true
  belongs_to :device, optional: true
  belongs_to :linter, optional: true

  after_create :set_severity

  def set_severity
    if severity_level == 1
      self.severity = 'warn'
    elsif severity_level == 2
      self.severity = 'error'
    end
  end
end
