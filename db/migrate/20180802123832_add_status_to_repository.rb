class AddStatusToRepository < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :status, :string
  end
end
