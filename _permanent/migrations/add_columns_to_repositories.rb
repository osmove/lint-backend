# rails g migration add_columns_to_repositories
# web_url
# html_url
# git_url
# ssh_url
# github_updated_at:datetime
# github_created_at:datetime
# imported_at:datetime
# git_host
# is_archived:boolean
# size:integer
# has_downloads:boolean
# has_wiki:boolean
# is_ignored:boolean

class AddColumnsToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :web_url, :string
    add_column :repositories, :html_url, :string
    add_column :repositories, :git_url, :string
    add_column :repositories, :ssh_url, :string
    add_column :repositories, :github_updated_at, :datetime
    add_column :repositories, :github_created_at, :datetime
    add_column :repositories, :imported_at, :datetime
    add_column :repositories, :git_host, :string
    add_column :repositories, :is_archived, :boolean
    add_column :repositories, :size, :integer
    add_column :repositories, :has_downloads, :boolean
    add_column :repositories, :has_wiki, :boolean
    add_column :repositories, :is_ignored, :boolean
  end
end
