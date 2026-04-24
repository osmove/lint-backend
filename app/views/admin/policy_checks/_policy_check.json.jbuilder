json.extract! policy_check, :id, :name, :passed, :commit_attempt_id, :policy_id, :repository_id, :user_id, 
              :contributor_id, :push_id, :device_id, :created_at, :updated_at
json.url policy_check_url(policy_check, format: :json)
