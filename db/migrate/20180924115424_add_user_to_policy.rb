class AddUserToPolicy < ActiveRecord::Migration[5.1]
  def change
    add_reference :policies, :user, foreign_key: true
  end
end
