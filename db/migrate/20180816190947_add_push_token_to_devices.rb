class AddPushTokenToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :pushToken, :string
  end
end
