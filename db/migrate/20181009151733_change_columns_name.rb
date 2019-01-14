class ChangeColumnsName < ActiveRecord::Migration[5.1]
  def change
    rename_column :policy_rules, :fix,  :autofix
    rename_column :rules, :fix, :fixable
  end
end
