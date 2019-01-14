class ChangeColumnInHostingPlans2 < ActiveRecord::Migration[5.1]
  def change
    remove_column :hosting_plans, :memory
    add_column :hosting_plans, :memory, :decimal, precision: 5, scale: 2
  end
end
