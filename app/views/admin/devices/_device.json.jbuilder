json.extract! device, :id, :user_id, :type, :brand, :model, :sub_model, :uuid, :os, :os_version, :has_notifications, :has_omnilint_desktop, :has_omnilint_connect, :last_seen, :browser, :user_agent, :created_at, :updated_at
json.url device_url(device, format: :json)
