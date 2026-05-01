require 'test_helper'

class UserOsmoveOmniauthTest < ActiveSupport::TestCase
  test 'creates an osmove user from omniauth data' do
    auth = OmniAuth::AuthHash.new(
      provider: 'osmove',
      uid: 'usr_123',
      info: {
        email: 'sso@example.com',
        name: 'SSO User'
      }
    )

    user = User.from_osmove_omniauth(auth)

    assert user.persisted?
    assert_equal 'osmove', user.provider
    assert_equal 'usr_123', user.uid
    assert_equal 'sso@example.com', user.email
    assert_equal 'sso-user', user.username
  end

  test 'links osmove identity to an existing user with same email' do
    user = users(:one)
    auth = OmniAuth::AuthHash.new(
      provider: 'osmove',
      uid: 'usr_existing',
      info: {
        email: user.email,
        name: 'Existing User'
      }
    )

    found = User.from_osmove_omniauth(auth)

    assert_equal user.id, found.id
    assert_equal 'osmove', found.provider
    assert_equal 'usr_existing', found.uid
  end
end
