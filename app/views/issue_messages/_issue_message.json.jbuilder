json.extract! issue_message, :id, :title, :slug, :body, :username, :issue_id, :repository_id, :user_id, :created_at, 
              :updated_at
json.url issue_message_url(issue_message, format: :json)
