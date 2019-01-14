json.extract! team, :id, :name, :avatar_url, :parent_id, :description, :organization_id, :created_at, :updated_at
json.url team_url(team, format: :json)
