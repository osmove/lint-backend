class CreateHostingPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :hosting_plans do |t|
      t.string :name
      t.string :slug
      t.integer :memory
      t.integer :vcpus
      t.integer :storage
      t.integer :transfer
      t.string :price_per_month
      t.string :price_per_hour
      t.timestamps
    end
  end
end
