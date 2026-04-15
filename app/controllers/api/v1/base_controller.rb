module Api
  module V1
    class BaseController < ActionController::Base
      protect_from_forgery with: :null_session
      before_action :authenticate_api_user!

      private

      def authenticate_api_user!
        token = extract_token
        @current_user = token && User.find_by(authentication_token: token)

        unless @current_user
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end

      def extract_token
        # Support both header and param-based auth
        if request.headers["Authorization"].present?
          request.headers["Authorization"].split(" ").last
        else
          params[:user_token]
        end
      end

      def current_user
        @current_user
      end
    end
  end
end
