json.extract! push, :id, :repository_id, :user_id, :created_at, :updated_at
json.url push_url(push, format: :json)
