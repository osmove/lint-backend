class AddColumnFixToPolicyRule < ActiveRecord::Migration[5.1]
  def change
    add_column :policy_rules, :fix, :boolean, default: false
  end
end
