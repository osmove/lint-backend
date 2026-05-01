require 'test_helper'
require 'openssl'

module Api
  module V1
    class ReviewControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @osmove_key = OpenSSL::PKey::RSA.generate(2048)
      end

      test 'accepts existing Lint authentication tokens' do
        with_code_reviewer_stub do
          post '/api/v1/review',
               params: review_params,
               headers: { 'Authorization' => "Bearer #{@user.authentication_token}" },
               as: :json
        end

        assert_response :success
        assert_equal 'Use a safer pattern.', response.parsed_body.dig('reviews', 0, 'ai_suggestion')
      end

      test 'accepts Osmove JWTs with required scope' do
        @user.update!(provider: 'osmove', uid: 'usr_lint_1')

        with_osmove_env do
          with_code_reviewer_stub do
            post '/api/v1/review',
                 params: review_params,
                 headers: { 'Authorization' => "Bearer #{osmove_token(sub: 'usr_lint_1', scope: 'lint.reviews:create')}" },
                 as: :json
          end
        end

        assert_response :success
        assert_equal 'Use a safer pattern.', response.parsed_body.dig('reviews', 0, 'ai_suggestion')
      end

      test 'maps Osmove JWTs by service user id' do
        with_osmove_env do
          with_code_reviewer_stub do
            post '/api/v1/review',
                 params: review_params,
                 headers: {
                   'Authorization' => "Bearer #{osmove_token(scope: 'lint.reviews:create', service_user_ids: { lint: @user.id.to_s })}"
                 },
                 as: :json
          end
        end

        assert_response :success
      end

      test 'rejects Osmove JWTs without required scope' do
        @user.update!(provider: 'osmove', uid: 'usr_lint_2')

        with_osmove_env do
          post '/api/v1/review',
               params: review_params,
               headers: { 'Authorization' => "Bearer #{osmove_token(sub: 'usr_lint_2', scope: 'lint.repositories:read')}" },
               as: :json
        end

        assert_response :forbidden
        assert_equal 'lint.reviews:create', response.parsed_body['required_scope']
      end

    private

      def review_params
        {
          violations: [
            {
              rule_name: 'Security/Open',
              file_path: 'app/models/user.rb',
              line: 12,
              message: 'avoid unsafe open'
            }
          ]
        }
      end

      def with_code_reviewer_stub
        fake = Class.new do
          def review_violation(**)
            'Use a safer pattern.'
          end
        end
        original = Ai::CodeReviewer
        Ai.send(:remove_const, :CodeReviewer)
        Ai.const_set(:CodeReviewer, fake)
        yield
      ensure
        Ai.send(:remove_const, :CodeReviewer)
        Ai.const_set(:CodeReviewer, original)
      end

      def with_osmove_env
        previous = {
          'OSMOVE_JWT_PUBLIC_KEY' => ENV.fetch('OSMOVE_JWT_PUBLIC_KEY', nil),
          'OSMOVE_ISSUER' => ENV.fetch('OSMOVE_ISSUER', nil),
          'OSMOVE_AUDIENCE' => ENV.fetch('OSMOVE_AUDIENCE', nil)
        }
        ENV['OSMOVE_JWT_PUBLIC_KEY'] = @osmove_key.public_key.to_pem
        ENV['OSMOVE_ISSUER'] = 'https://accounts.test.osmove'
        ENV['OSMOVE_AUDIENCE'] = 'lint'
        OsmoveJwtVerifier.clear_cache!
        yield
      ensure
        previous.each { |key, value| value.nil? ? ENV.delete(key) : ENV[key] = value }
        OsmoveJwtVerifier.clear_cache!
      end

      def osmove_token(scope:, sub: 'usr_lint', service_user_ids: {})
        JWT.encode(
          {
            iss: ENV.fetch('OSMOVE_ISSUER'),
            sub: sub,
            aud: 'lint',
            iat: Time.current.to_i,
            exp: 1.hour.from_now.to_i,
            scope: scope,
            service_user_ids: service_user_ids
          },
          @osmove_key,
          'RS256',
          kid: 'test-osmove'
        )
      end
    end
  end
end
