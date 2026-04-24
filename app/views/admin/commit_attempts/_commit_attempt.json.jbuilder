json.extract! commit_attempt, :id, :message, :description, :commit_id, :user_id, :contributor_id, :push_id, :device_id, 
              :repository_id, :created_at, :updated_at
json.(commit_attempt.repository, :id, :name, :slug, :status, :user_id, :created_at, :updated_at, :uuid, 
      :has_encryption, :is_encrypted, :has_deployment, :policy, :commits, :documents)
json.(commit_attempt.repository.policy)

json.url commit_attempt_url(commit_attempt, format: :json)
