class AddBelongsToToPolicyRuleOptionOption < ActiveRecord::Migration[5.1]
  def change
    add_reference :policy_rule_option_options, :rule_option_option, foreign_key: true
  end
end
