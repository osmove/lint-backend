json.extract! rule, :id, :name, :type, :description, :status, :language_id, :framework_id, :platform_id, :parent,
              :created_at, :updated_at
json.url rule_url(rule, format: :json)
