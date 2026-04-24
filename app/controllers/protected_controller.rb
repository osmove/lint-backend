class ProtectedController < ApplicationController


    impressionist

  # API Authentication - comes before Devise's one
  before_action :authenticate_user_from_token!, if: :json_request?
  # before_action :check_access, if: :json_request?
  # Devise
  before_action :authenticate_user!, unless: :json_request?

  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_timezone

private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :provider, :uid])
    end

    def set_timezone
      Time.zone = "UTC"
      if current_user && current_user.time_zone.present?
        Time.zone = current_user.time_zone
      end
    end

    def json_request?
      request.format.json?
    end

    def authenticate_user_from_token!
      user_token = params[:user_token].presence
      user       = user_token && User.find_by_authentication_token(user_token.to_s)

      if user
        sign_in user, store: false
      else
        respond_to do |format|
          format.html { redirect_to new_user_session_path, notice: 'Authentication required.' }
          format.json { render json: { signed_in: false }, status: :unauthorized }
        end
      end
    end




end
