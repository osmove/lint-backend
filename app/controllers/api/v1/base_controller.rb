module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_api_user!

    private

      def authenticate_api_user!
        token = extract_token
        @current_user = token && User.find_by(authentication_token: token)
        @current_auth_provider = :lint if @current_user

        return if @current_user

        payload = OsmoveJwtVerifier.decode(token)
        @current_user = payload && user_from_osmove_claims(payload)
        if @current_user
          @current_auth_provider = :osmove
          @current_token_payload = payload
          return
        end

        render json: { error: 'Unauthorized' }, status: :unauthorized
      end

      def require_scope!(scope)
        return true unless @current_auth_provider == :osmove
        return true if current_token_scopes.include?(scope)

        render json: { error: 'Forbidden', required_scope: scope }, status: :forbidden
        false
      end

      def current_token_scopes
        raw = @current_token_payload&.fetch('scope', '')
        raw.is_a?(Array) ? raw.map(&:to_s) : raw.to_s.split(/\s+/)
      end

      def user_from_osmove_claims(payload)
        lint_user_id = payload.dig('service_user_ids', 'lint').to_s
        return User.find_by(id: lint_user_id) if lint_user_id.match?(/\A\d+\z/)

        user = User.find_by(provider: 'osmove', uid: payload['sub'])
        return user if user

        email = payload['email'].to_s.downcase.presence
        User.find_by(email: email) if email
      end

      def extract_token
        # Support both header and param-based auth
        if request.headers['Authorization'].present?
          request.headers['Authorization'].split.last
        else
          params[:user_token]
        end
      end

      attr_reader :current_user
    end
  end
end
