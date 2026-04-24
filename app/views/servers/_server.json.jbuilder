json.extract! server, :id, :name, :ip_address, :os, :ssh_host, :ssh_user, :ssh_password, :ssh_path, :user_id, 
              :created_at, :updated_at
json.url server_url(server, format: :json)
