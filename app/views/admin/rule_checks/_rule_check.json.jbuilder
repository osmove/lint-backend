json.extract! rule_check, :id, :name, :passed, :language_id, :rule_id, :policy_check_id, :repository_id, :user_id, 
              :contributor_id, :push_id, :device_id, :created_at, :updated_at
json.url rule_check_url(rule_check, format: :json)
