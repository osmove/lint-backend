class RenamePushToken < ActiveRecord::Migration[5.1]
  def change
    rename_column(:devices, :pushToken, :push_token)
  end
end
