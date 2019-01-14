class CreatePolicyRules < ActiveRecord::Migration[5.1]
  def change
    create_table :policy_rules do |t|
      t.references :rule, foreign_key: true
      t.references :policy, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
