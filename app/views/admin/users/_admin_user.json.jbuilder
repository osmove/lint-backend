json.extract! admin_user, :id, :created_at, :updated_at, :username, :login, :slug, :first_name, :last_name, :email,
              :password, :password_confirmation, :birthday, :phone_country_code, :phone_number, :gender, :address, :address_2, :city, :zip_code, :state, :country, :is_organization, :has_newsletter, :terms_acceptance_date, :locale, :language, :time_zone, :accepted_terms_and_conditions, :role
json.url admin_user_url(admin_user, format: :json)
