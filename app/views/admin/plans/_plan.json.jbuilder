json.extract! plan, :id, :name, :slug, :description, :price_per_month, :price_per_year, :max_users, :max_repositories, 
              :max_storage, :created_at, :updated_at
json.url plan_url(plan, format: :json)
