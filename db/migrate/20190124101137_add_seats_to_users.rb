class AddSeatsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :number_of_seats, :integer
  end
end
