class AddColumnStatusToPolicyRules < ActiveRecord::Migration[5.1]
  def change
    add_column :policy_rules, :status, :string
  end
end
