class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :time_zone, :string
    add_column :users, :locale, :string
    add_column :users, :language, :string
  end
end
