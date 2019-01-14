require 'test_helper'

class IssueMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue_message = issue_messages(:one)
  end

  test "should get index" do
    get issue_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_issue_message_url
    assert_response :success
  end

  test "should create issue_message" do
    assert_difference('IssueMessage.count') do
      post issue_messages_url, params: { issue_message: { body: @issue_message.body, issue_id: @issue_message.issue_id, repository_id: @issue_message.repository_id, slug: @issue_message.slug, title: @issue_message.title, user_id: @issue_message.user_id, username: @issue_message.username } }
    end

    assert_redirected_to issue_message_url(IssueMessage.last)
  end

  test "should show issue_message" do
    get issue_message_url(@issue_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_issue_message_url(@issue_message)
    assert_response :success
  end

  test "should update issue_message" do
    patch issue_message_url(@issue_message), params: { issue_message: { body: @issue_message.body, issue_id: @issue_message.issue_id, repository_id: @issue_message.repository_id, slug: @issue_message.slug, title: @issue_message.title, user_id: @issue_message.user_id, username: @issue_message.username } }
    assert_redirected_to issue_message_url(@issue_message)
  end

  test "should destroy issue_message" do
    assert_difference('IssueMessage.count', -1) do
      delete issue_message_url(@issue_message)
    end

    assert_redirected_to issue_messages_url
  end
end
