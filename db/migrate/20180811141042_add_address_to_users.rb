class AddAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string
    add_column :users, :address_2, :string
    add_column :users, :city, :string
    add_column :users, :zip_code, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :is_organization, :boolean
    add_column :users, :organization_name, :string
    add_reference :users, :organization, foreign_key: true
  end
end
