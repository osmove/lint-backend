class AddOptionToPolicyRules < ActiveRecord::Migration[5.1]
  def change
    add_column :policy_rules, :option, :string
  end
end
