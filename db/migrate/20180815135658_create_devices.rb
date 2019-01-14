class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.references :user, foreign_key: true
      t.string :type
      t.string :brand
      t.string :model
      t.string :sub_model
      t.string :uuid
      t.string :os
      t.string :os_version
      t.boolean :has_notifications
      t.boolean :has_gatrix_desktop
      t.boolean :has_gatrix_connect
      t.datetime :last_seen
      t.string :browser
      t.string :user_agent

      t.timestamps
    end
  end
end
