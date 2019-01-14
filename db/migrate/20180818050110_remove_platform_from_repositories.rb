class RemovePlatformFromRepositories < ActiveRecord::Migration[5.1]
  def change
    remove_column :repositories, :platform
  end
end
