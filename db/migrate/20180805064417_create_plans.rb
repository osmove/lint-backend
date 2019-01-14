class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :price_per_month
      t.string :price_per_year
      t.integer :max_users
      t.integer :max_repositories
      t.integer :max_storage

      t.timestamps
    end
  end
end
