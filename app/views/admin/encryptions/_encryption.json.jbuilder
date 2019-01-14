json.extract! encryption, :id, :status, :cypher_name, :document_id, :repository_id, :user_id, :created_at, :updated_at
json.url encryption_url(encryption, format: :json)
