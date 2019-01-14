class RemoveJoinTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :repositories_users
  end
end
