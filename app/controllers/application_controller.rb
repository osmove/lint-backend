class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone
  before_action :set_smart_ip

  # before_action :authenticate_user

  # layout "dashboard" if user_signed_in?
  # layout :determine_layout

  before_action :set_repository

  # Render Devise (sign-in, sign-up, forgot-password, etc.) under
  # the modernized Tailwind marketing layout, not the legacy
  # application layout. Other controllers can still set their own
  # layout — this only fires when the request comes from Devise.
  layout :devise_aware_layout

protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
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
    return unless current_user

    Time.zone = current_user.time_zone if current_user.time_zone
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def determine_layout
    current_user ? 'dashboard' : 'application'
  end

  def devise_aware_layout
    devise_controller? ? 'lint_marketing' : 'application'
  end

  def set_smart_ip
    forwared_for_ip = request.env['HTTP_X_FORWARDED_FOR']
    @smart_ip = 'UNKNOWN'
    @smart_ip = if forwared_for_ip.present? && forwared_for_ip.split(', ').length > 1
                  forwared_for_ip.split(', ').first
                elsif forwared_for_ip.present?
                  forwared_for_ip
                else
                  request.remote_ip
                end
    @smart_ip

    # response = Net::HTTP.get(URI.parse("https://www.iplocate.io/api/lookup/#{@smart_ip}")) rescue nil
    # country = JSON.parse(response)["country"] rescue nil
  end

  def set_repository
    return if @repository.present?

    repository_slug = params[:repository_id] || params[:id]
    user_slug = params[:user_id]
    return unless repository_slug.present? && user_slug.present?

    @repository = begin
      Repository.where(uuid: "#{user_slug}/#{repository_slug}").first
    rescue StandardError
      nil
    end
  end
end
