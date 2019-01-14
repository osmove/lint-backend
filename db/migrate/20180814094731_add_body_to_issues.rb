class AddBodyToIssues < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :body, :text
    add_column :issues, :status, :string
  end
end
