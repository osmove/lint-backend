require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Osmove < OmniAuth::Strategies::OAuth2
      option :name, 'osmove'
      option :pkce, true
      option :scope, 'openid profile email'
      option :client_options, {
        site: 'https://accounts.osmove.com',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }
      option :user_info_url, '/api/v1/hub/me'

      uid { user_info['sub'].to_s }

      info do
        {
          email: user_info['email'],
          name: user_info['name']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get(options.user_info_url.to_s).parsed
      end

      def user_info
        raw_info['user'] || raw_info
      end
    end
  end
end

OmniAuth.config.add_camelization 'osmove', 'Osmove'
