require 'test_helper'

class PostmarkControllerTest < ActionDispatch::IntegrationTest
  test "should get inbound" do
    get postmark_inbound_url
    assert_response :success
  end

end
