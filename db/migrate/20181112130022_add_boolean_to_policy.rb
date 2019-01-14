class AddBooleanToPolicy < ActiveRecord::Migration[5.1]
  def change
    add_column :policies, :prevent_commits_on_errors, :boolean, default: true
  end
end
