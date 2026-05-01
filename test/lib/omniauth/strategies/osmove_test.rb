require 'test_helper'
require Rails.root.join('lib/omniauth/strategies/osmove').to_s

class OmniauthOsmoveStrategyTest < ActiveSupport::TestCase
  test 'maps Osmove Identity userinfo into omniauth uid and info' do
    strategy = OmniAuth::Strategies::Osmove.new(nil, 'client-id', 'secret')
    parsed_response = {
      'user' => {
        'sub' => 'usr_123',
        'email' => 'sso@example.com',
        'name' => 'SSO User'
      }
    }
    token = Class.new do
      response = Struct.new(:parsed, keyword_init: true)
      define_method(:initialize) { |payload| @payload = payload }
      define_method(:get) { |_url| response.new(parsed: @payload) }
    end.new(parsed_response)
    strategy.access_token = token

    assert_equal 'usr_123', strategy.uid
    assert_equal 'sso@example.com', strategy.info[:email]
    assert_equal 'SSO User', strategy.info[:name]
  end

  test 'enables pkce by default' do
    strategy = OmniAuth::Strategies::Osmove.new(nil, 'client-id', 'secret')

    assert_equal true, strategy.options.pkce
    assert_equal 'openid profile email', strategy.options.scope
  end
end
