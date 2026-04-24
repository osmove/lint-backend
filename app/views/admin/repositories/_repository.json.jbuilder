json.extract! repository, :id, :name, :slug, :status, :user_id, :created_at, :updated_at, :uuid, :has_encryption, 
              :is_encrypted, :has_deployment
json.url user_repository_url(repository.user, repository)
