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
