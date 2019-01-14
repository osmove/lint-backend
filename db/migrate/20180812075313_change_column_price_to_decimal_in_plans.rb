class ChangeColumnPriceToDecimalInPlans < ActiveRecord::Migration[5.1]
  def change
    # change_column :plans, :price_per_month, :decimal, precision: 10, scale: 2
    # change_column :plans, :price_per_year, :decimal, precision: 10, scale: 2

    change_column :plans, :price_per_month, 'decimal USING price_per_month::numeric(10,2)'
    change_column :plans, :price_per_year, 'decimal USING price_per_month::numeric(10,2)'

    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :stripe_product_id, :string

    add_column :plans, :stripe_subscription_id, :string
    add_column :plans, :stripe_product_id, :string


  end
end
