class ReaddPushTokenToDevices < ActiveRecord::Migration[5.1]
  def change
    remove_column :devices, :push_token
    add_column :devices, :push_token, :string
  end
end
