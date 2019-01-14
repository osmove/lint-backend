class AddColumnsToPolicyCheck < ActiveRecord::Migration[5.1]
  def change
    add_column :policy_checks, :error_count, :integer
    add_column :policy_checks, :warning_count, :integer
    add_column :policy_checks, :offense_count, :integer
    add_column :policy_checks, :fixable_warning_count, :integer
    add_column :policy_checks, :fixable_error_count, :integer
    add_column :policy_checks, :fixable_offense_count, :integer

  end
end
