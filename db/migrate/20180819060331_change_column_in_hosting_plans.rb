class ChangeColumnInHostingPlans < ActiveRecord::Migration[5.1]
  def change
    remove_column :hosting_plans, :price_per_month
    add_column :hosting_plans, :price_per_month, :decimal, precision: 10, scale: 2
    remove_column :hosting_plans, :price_per_hour
    add_column :hosting_plans, :price_per_hour, :decimal, precision: 10, scale: 2
  end
end
