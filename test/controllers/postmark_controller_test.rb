require 'test_helper'

class PostmarkControllerTest < ActionDispatch::IntegrationTest
  test 'should create message from inbound webhook' do
    payload = {
      FromName: 'Lint User',
      From: 'user@example.com',
      To: 'support@lint.to',
      Subject: 'Inbound email',
      TextBody: 'Hello from Postmark',
      HtmlBody: '<p>Hello from Postmark</p>'
    }

    assert_difference('Message.count', 1) do
      post postmark_inbound_url,
           params: payload.to_json,
           headers: {
             'CONTENT_TYPE' => 'application/json',
             'ACCEPT' => 'application/json'
           }
    end

    assert_response :created
  end
end
