class ChangeColumnInHostingPlans3 < ActiveRecord::Migration[5.1]
  def change
    remove_column :hosting_plans, :memory
    add_column :hosting_plans, :memory, :integer, limit: 8 # BIGINT
    remove_column :hosting_plans, :storage
    add_column :hosting_plans, :storage, :integer, limit: 8 # BIGINT
    remove_column :hosting_plans, :transfer
    add_column :hosting_plans, :transfer, :integer, limit: 8 # BIGINT
  end
end
