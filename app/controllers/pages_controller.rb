class PagesController < ApplicationController
# class PagesController < ProtectedController

  require "open-uri"
  require "json"
  require "set"

  impressionist


  # layout "dashboard", only: :dashboard
  layout "marketing", except: [:dashboard, :select_repositories]

  layout "prelaunch", only: [:prelaunch, :available_soon]

  # before_action :authenticate_user!, except: :home
  before_action :authenticate_user!, except: [:prelaunch, :available_soon]

  def home
    @resource ||= User.new
  end

  def select_repositories
    @user = current_user
    @github_repos = Repository.new
    @organizations = User.where(is_organization: true)
  end

  def prelaunch
    @resource ||= User.new
    # render :home
  end

  def features
    @resource ||= User.new
  end

  def apps
    @resource ||= User.new
  end

  def cloud
    @resource ||= User.new
  end

  def security
    @resource ||= User.new
  end

  def faq
    @resource ||= User.new
  end

  def pricing
    @resource ||= User.new
  end

  def downloads
    @resource ||= User.new
  end

  def desktop
    @resource ||= User.new
  end

  def web
    @resource ||= User.new
  end

  def connect
    @resource ||= User.new
  end

  def cli
    @resource ||= User.new
  end


  def deploy
    @resource ||= User.new
  end

  def terms
    @resource ||= User.new
  end

  def privacy
    @resource ||= User.new
  end

  def available_soon

  end

  def dashboard
    @user = current_user
    
    @private_repositories = Repository.all.where(user: @user).private.includes(:commits).order('commits.created_at DESC NULLS LAST')
    @public_repositories = Repository.all.where(user: @user).public.includes(:commits).order('commits.created_at DESC NULLS LAST')
    @private_repositories_count = @private_repositories.length
    @public_repositories_count = @public_repositories.length
    @memberships = @user.memberships
    @organizations_of_current_user = []

    @memberships.each do |membership|
      if membership.organization.present?
        org = User.find(membership.organization_id)
        @organizations_of_current_user |= [org]
      end
    end

    #display repo
    @passed_param = session[:passed_variable]
    @github_repos = @passed_param

    require 'rqrcode'
    qrcode = RQRCode::QRCode.new("https://omnilint.com/#{current_user.slug}")
    @qrcode_svg = qrcode.as_svg(offset: 0, color: '333', shape_rendering: 'crispEdges', module_size: 4, width: '100%')
    # @qrcode_html = qrcode.as_html
    @all_repos =  @user.repositories_with_access + Repository.all.where(user: @user)
    @all_repos = @all_repos.sort_by{|a| a[:updated_at]}.reverse!.first(10)

    @last_commits = @all_repos.flat_map(&:commits).sort_by{|a| a[:created_at]}.reverse!.first(10)

    # @last_commits = @user.commits.order(created_at: :desc).first(10)
    # @last_commit_attempts = @user.repositories.commit_attempts.order(created_at: :desc).first(10)
    @last_commit_attempts = @all_repos.flat_map(&:commit_attempts).sort_by{|e| e[:created_at]}.reverse!.first(10)


    #
    # expoPushClient = Exponent::Push::Client.new
    # messages = [
    #   {
    #     to: "ExponentPushToken[MdmlDhE-G4HFOtxwnMtOHf]",
    #     sound: "default",
    #     body: "New connection detected to your dashboard from IP: #{request.remote_ip}."
    #     # body: "Hello world!"
    #   },
    #   # {
    #   #   to: "ExponentPushToken[yyyyyyyyyyyyyyyyyyyyyy]",
    #   #   badge: 1,
    #   #   body: "You've got mail"
    #   # }
    # ]
    #
    # expoPushClient.publish(messages)




    # Send welcome push notification
    # push_messages = []
    # current_user.devices.each do |device|
    #   if device.has_notifications? && device.push_token.present?
    #     push_message = {
    #       to: device.push_token,
    #       sound: "default",
    #       body: "Welcome to Gatrix, #{current_user.username}."
    #     }
    #     push_messages << push_message
    #   end
    # end
    #
    # if push_messages.length > 0
    #   expo_push_client = Exponent::Push::Client.new
    #   expo_push_client.publish(push_messages)
    # end



    # Calculate Smart IP
    # forwared_for_ip = request.env['HTTP_X_FORWARDED_FOR']
    # @smart_ip = ""
    # # if forwared_for_ip.present? && forwared_for_ip.kind_of?(Array)
    # if forwared_for_ip.present? && forwared_for_ip.split(", ").length > 1
    #   @smart_ip = forwared_for_ip.split(", ").first
    # elsif forwared_for_ip.present?
    #   @smart_ip = forwared_for_ip
    # else
    #   @smart_ip = request.remote_ip
    # end

    response = Net::HTTP.get(URI.parse("https://www.iplocate.io/api/lookup/#{@smart_ip}")) rescue nil
    result = JSON.parse(response)
    country = result["country"] || "unknown country" rescue nil
    country_code = result["country_code"] || "UNKNOWN" rescue nil

    if current_user.country.present? && current_user.country != country_code
      current_user.send_push_notification(
        "Connection from #{country}",
        "Hi, #{current_user.username}. New connection detected to your Gatrix Dashboard with IP #{@smart_ip}."
      )
    end


    current_user.send_push_notification(
      "Connection from #{country}",
      "Hi, #{current_user.username}. New connection detected to your Gatrix Dashboard with IP #{@smart_ip}."
    )


    #
    # # Send security alert push notification
    # push_messages = []
    # current_user.devices.each do |device|
    #   if device.has_notifications? && device.push_token.present?
    #     push_message = {
    #       to: device.push_token,
    #       sound: "default",
    #       body: "Hi, #{current_user.username}. A new connection to your Gatrix dashboard was detected from #{country} - IP #{@smart_ip}."
    #     }
    #     push_messages << push_message
    #   end
    # end
    #
    # if push_messages.length > 0
    #   expo_push_client = Exponent::Push::Client.new
    #   expo_push_client.publish(push_messages)
    # end



  end

  private

    def resource_name
      :user
    end
    helper_method :resource_name

    def resource
      @resource ||= User.new
    end
    helper_method :resource

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
    helper_method :devise_mapping

    def resource_class
      User
    end
    helper_method :resource_class

end
