json.extract! hosting_plan, :id, :name, :slug, :memory, :vcpus, :storage, :price_per_month, :price_per_hour, 
              :created_at, :updated_at
json.url hosting_plan_url(hosting_plan, format: :json)
