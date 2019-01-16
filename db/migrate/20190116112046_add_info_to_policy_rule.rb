class AddInfoToPolicyRule < ActiveRecord::Migration[5.1]
  def change
    add_column :policy_rules, :name, :string
    add_column :policy_rules, :slug, :string
    add_column :policy_rules, :description, :text
    add_column :policy_rules, :type, :string
    add_column :policy_rules, :fixable, :boolean
    change_column :rules, :description, :text
  end
end
