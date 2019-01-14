json.extract! contributor, :id, :name, :email, :repository_id, :user_id, :created_at, :updated_at
json.url contributor_url(contributor, format: :json)
