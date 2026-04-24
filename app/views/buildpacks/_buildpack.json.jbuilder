json.extract! buildpack, :id, :name, :web_address, :git_address, :command_id, :repository_id, :user_id, :created_at,
              :updated_at
json.url buildpack_url(buildpack, format: :json)
