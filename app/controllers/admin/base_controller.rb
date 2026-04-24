module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user_by_role

    layout :layout_by_resource

    # edit valid roles here
    VALID_ROLES = ['admin'].freeze

    def dashboard; end

  protected

    # redirect if user not logged in or does not have a valid role
    def restrict_user_by_role
      if current_user.present?
        unless VALID_ROLES.include?(current_user.role)
          redirect_to root_path # change this to your 404 page if needed
        end
      else
        redirect_to new_user_session_path
      end
    end

  private

    def layout_by_resource
      if devise_controller?
        'application'
      else
        'admin'
      end
    end
  end
end
