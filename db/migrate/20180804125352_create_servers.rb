class CreateServers < ActiveRecord::Migration[5.1]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :ip_address
      t.string :os
      t.string :ssh_host
      t.string :ssh_user
      t.string :ssh_password
      t.string :ssh_path
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
