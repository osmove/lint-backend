class CreatePolicyRuleOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_rule_options do |t|
      t.references :policy_rule, foreign_key: true
      t.references :rule_option, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
