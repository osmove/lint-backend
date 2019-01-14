json.extract! push, :id, :repository_id, :user_id, :commit_ids, :created_at, :updated_at
json.url push_url(push, format: :json)
