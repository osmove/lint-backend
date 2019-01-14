json.extract! membership, :id, :username, :origin, :origin_url, :avatar_url, :role, :user_id, :team_id, :created_at, :updated_at
json.url membership_url(membership, format: :json)
