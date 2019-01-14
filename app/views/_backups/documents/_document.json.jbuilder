json.extract! document, :id, :name, :path, :is_folder, :size, :extension, :content, :repository_id, :document_id, :created_at, :updated_at
json.url user_repository_document_url(@user, @repository, document, format: :json)
