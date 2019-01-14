class AddAuthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authentication_token, :string
    create_join_table :repositories, :users
  end
end
