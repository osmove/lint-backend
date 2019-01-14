class CreatePolicyRuleOptionOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_rule_option_options do |t|
      t.references :policy_rule_option, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
