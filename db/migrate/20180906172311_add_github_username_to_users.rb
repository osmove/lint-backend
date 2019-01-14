class AddGithubUsernameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :github_username, :string
    add_column :users, :github_id, :string
  end
end
