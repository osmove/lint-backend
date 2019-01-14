class PolicyRuleOptionOption < ApplicationRecord
  belongs_to :policy_rule_option, optional: true, touch: true
  belongs_to :rule_option_option, optional: true


  def short_description
    max = 80
    self.description.length > max ? "#{self.description[0...max]}..." : self.description
  end


end
