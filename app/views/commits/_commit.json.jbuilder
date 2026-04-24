json.extract! commit, :id, :message, :date, :date_raw, :contributor_raw, :contributor_name, :contributor_email,
              :repository_id, :user_id, :created_at, :updated_at
json.url user_repository_commit_url(@user, @repository, commit, format: :json)
