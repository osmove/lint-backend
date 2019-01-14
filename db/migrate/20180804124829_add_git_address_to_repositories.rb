class AddGitAddressToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :git_address, :string
    add_column :repositories, :web_address, :string
    add_column :repositories, :has_encryption, :boolean
    add_column :repositories, :is_encrypted, :boolean
    add_column :repositories, :is_app, :boolean
    add_column :repositories, :has_deployment, :boolean
  end
end
