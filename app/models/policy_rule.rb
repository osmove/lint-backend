class PolicyRule < ApplicationRecord
  belongs_to :rule, optional: true
  belongs_to :policy, optional: true, touch: true

  has_many :policy_rule_options, :dependent => :destroy
  accepts_nested_attributes_for :policy_rule_options, allow_destroy: true

  has_many :policy_rule_option_options, through: :policy_rule_options

  has_many :rule_option, through: :policy_rule_options



  STATUS_OPTIONS = [['Off', 'off'], ['Warn', 'warn'], ['Error', 'error']]

  after_initialize do
    self.status ||= "off"
  end

  def short_description
    max = 80
    self.description.length > max ? "#{self.description[0...max]}..." : self.description
  end

end
