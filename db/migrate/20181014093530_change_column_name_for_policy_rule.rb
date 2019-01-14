class ChangeColumnNameForPolicyRule < ActiveRecord::Migration[5.1]
  def change
    rename_column :policy_rules, :option,  :options
  end
end
