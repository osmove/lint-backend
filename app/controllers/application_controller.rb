class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  respond_to :html, :json

  skip_before_action :verify_authenticity_token, if: :json_request?


  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone
  before_action :set_smart_ip


  # before_action :authenticate_user

  # layout "dashboard" if user_signed_in?
  # layout :determine_layout

  # impressionist unless: :json_request?

  before_action :set_repository


  before_action :set_raven_context

  protected

    def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

  # def after_sign_in_path_for(resource)
    # request.env['omniauth.origin']
    # if resource.github_username != nil
    #   root_path
    # else
    #   # request.env['omniauth.origin'] || onboarding_step_1_path || root_path
    #   root_path
    # end
  # end

  private

    def json_request?
      request.format.json?
    end

    def set_time_zone
      if current_user
        Time.zone = current_user.time_zone if current_user.time_zone
      end
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

    def determine_layout
      current_user ? "dashboard" : "application"
    end

    def set_raven_context
      Raven.user_context(id: session[:current_user_id]) # or anything else in session
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def set_smart_ip

      forwared_for_ip = request.env['HTTP_X_FORWARDED_FOR']
      @smart_ip = "UNKNOWN"
      if forwared_for_ip.present? && forwared_for_ip.split(", ").length > 1
        @smart_ip = forwared_for_ip.split(", ").first
      elsif forwared_for_ip.present?
        @smart_ip = forwared_for_ip
      else
        @smart_ip = request.remote_ip
      end
      @smart_ip

      # response = Net::HTTP.get(URI.parse("https://www.iplocate.io/api/lookup/#{@smart_ip}")) rescue nil
      # country = JSON.parse(response)["country"] rescue nil

    end



    def set_repository
      unless @repository.present?
        repository_slug = params[:repository_id] || params[:id]
        user_slug = params[:user_id]
        if repository_slug.present? && user_slug.present?
          @repository = Repository.where(uuid: "#{user_slug}/#{repository_slug}").first rescue nil
        end
      end
    end


end
