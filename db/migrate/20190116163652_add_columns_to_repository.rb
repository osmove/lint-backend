class AddColumnsToRepository < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :prevent_commits_on_errors, :boolean
    add_column :repositories, :send_reports, :boolean, default: true
  end
end
