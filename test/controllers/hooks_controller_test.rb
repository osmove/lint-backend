require 'test_helper'

class HooksControllerTest < ActionDispatch::IntegrationTest
  test 'should get post_receive' do
    get hooks_post_receive_url
    assert_response :success
  end
end
