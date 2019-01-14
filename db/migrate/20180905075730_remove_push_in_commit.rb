class RemovePushInCommit < ActiveRecord::Migration[5.1]
  def change
    remove_column :pushes, :commit_id
  end
end
