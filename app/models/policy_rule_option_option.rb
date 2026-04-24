class PolicyRuleOptionOption < ApplicationRecord
  belongs_to :policy_rule_option, optional: true, touch: true
  belongs_to :rule_option_option, optional: true

  def short_description
    max = 80
    description.length > max ? "#{description[0...max]}..." : description
  end
end
