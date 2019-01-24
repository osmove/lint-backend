class AddStripeInfoToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :stripe_monthly_plan_id, :string
    add_column :plans, :stripe_yearly_plan_id, :string
  end
end
