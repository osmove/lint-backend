class RemoveRuleOptionFromPolicyRuleOptionOption < ActiveRecord::Migration[5.1]
  def change
    remove_reference :policy_rule_option_options, :rule_option, foreign_key: true
  end
end
