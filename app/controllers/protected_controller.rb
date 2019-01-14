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
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :provider
    devise_parameter_sanitizer.for(:sign_up) << :uid
  end


  before_action :set_timezone

  private

    def set_timezone
      Time.zone = "UTC"
      if current_user && current_user.time_zone.present?
        Time.zone = current_user.time_zone
        # Time.zone = "Europe/London"
      else
        # Time.zone = "Europe/Paris"
        # Time.zone = "Asia/Jerusalem"
        Time.zone = "UTC"
      end
    end

    def json_request?
      request.format.json?
    end


    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:sign_up) << :provider
      devise_parameter_sanitizer.for(:sign_up) << :uid
    end


    # def check_access
    #   if params[:repository_id].present?
    #     repository = Repository.friendly.find(params[:repository_id])
    #     user_token = params[:user_token].presence
    #     user       = user_token && User.find_by_authentication_token(user_token.to_s)
    #
    #     if repository.users_with_access.include?(user) || repository.user == user
    #       # Notice we are passing store false, so the user is not
    #       # actually stored in the session and a token is needed
    #       # for every request. If you want the token to work as a
    #       # sign in token, you can simply remove store: false.
    #       sign_in user, store: false
    #     else
    #       # :unauthorizedelse
    #       # render :json => {"signed_in" => false}.to_json(), :status => 401 and return
    #
    #
    #       respond_to do |format|
    #         format.html { redirect_to new_user_session_path, notice: 'Authentication successful.' }
    #         format.json { render :json => {"You don't have access to this repository" => false}.to_json(), :status => 401 and return }
    #       end
    #
    #     end
    #   end
    # end


    # For this example, we are simply using token authentication
    # via parameters. However, anyone could use Rails's token
    # authentication features to get the token from a header.
    def authenticate_user_from_token!
      user_token = params[:user_token].presence
      user       = user_token && User.find_by_authentication_token(user_token.to_s)

      if user
        # Notice we are passing store false, so the user is not
        # actually stored in the session and a token is needed
        # for every request. If you want the token to work as a
        # sign in token, you can simply remove store: false.
        sign_in user, store: false
      else
        # :unauthorizedelse
        # render :json => {"signed_in" => false}.to_json(), :status => 401 and return


        respond_to do |format|
          format.html { redirect_to new_user_session_path, notice: 'Authentication successful.' }
          format.json { render :json => {"signed_in" => false}.to_json(), :status => 401 and return }
        end

      end
    end


    # # For this example, we are simply using token authentication
    # # via parameters. However, anyone could use Rails's token
    # # authentication features to get the token from a header.
    # def authenticate_user_from_token!
    #   user_token = params[:user_token].presence
    #   user       = user_token && User.find_by_authentication_token(user_token.to_s)
    #
    #   if user
    #     # Notice we are passing store false, so the user is not
    #     # actually stored in the session and a token is needed
    #     # for every request. If you want the token to work as a
    #     # sign in token, you can simply remove store: false.
    #     sign_in user, store: false
    #   end
    # end




end
