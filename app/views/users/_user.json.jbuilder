
json.extract! user, :id, :created_at, :updated_at, :username, :login, :slug, :first_name, :last_name, :email, :country, 
              :is_organization, :language, :role
json.url user_url(user, format: :json)
# 
# json.repositories user.repositories do |repo|
#   json.(repo, :id, :name, :slug, :status, :user_id, :created_at, :updated_at, :uuid, :has_encryption, :is_encrypted, :has_deployment, :policy, :commits, :documents)
# end
