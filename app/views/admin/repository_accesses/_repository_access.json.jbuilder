json.extract! repository_access, :id, :role, :status, :user_id, :repository_id, :created_at, :updated_at
json.url repository_access_url(repository_access, format: :json)
