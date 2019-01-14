class AddDeployToToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :deploy_to, :string
    add_column :repositories, :server_size, :string
  end
end
