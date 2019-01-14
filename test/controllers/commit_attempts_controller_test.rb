require 'test_helper'

class CommitAttemptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commit_attempt = commit_attempts(:one)
  end

  test "should get index" do
    get commit_attempts_url
    assert_response :success
  end

  test "should get new" do
    get new_commit_attempt_url
    assert_response :success
  end

  test "should create commit_attempt" do
    assert_difference('CommitAttempt.count') do
      post commit_attempts_url, params: { commit_attempt: { commit_id: @commit_attempt.commit_id, contributor_id: @commit_attempt.contributor_id, description: @commit_attempt.description, device_id: @commit_attempt.device_id, message: @commit_attempt.message, push_id: @commit_attempt.push_id, repository_id: @commit_attempt.repository_id, user_id: @commit_attempt.user_id } }
    end

    assert_redirected_to commit_attempt_url(CommitAttempt.last)
  end

  test "should show commit_attempt" do
    get commit_attempt_url(@commit_attempt)
    assert_response :success
  end

  test "should get edit" do
    get edit_commit_attempt_url(@commit_attempt)
    assert_response :success
  end

  test "should update commit_attempt" do
    patch commit_attempt_url(@commit_attempt), params: { commit_attempt: { commit_id: @commit_attempt.commit_id, contributor_id: @commit_attempt.contributor_id, description: @commit_attempt.description, device_id: @commit_attempt.device_id, message: @commit_attempt.message, push_id: @commit_attempt.push_id, repository_id: @commit_attempt.repository_id, user_id: @commit_attempt.user_id } }
    assert_redirected_to commit_attempt_url(@commit_attempt)
  end

  test "should destroy commit_attempt" do
    assert_difference('CommitAttempt.count', -1) do
      delete commit_attempt_url(@commit_attempt)
    end

    assert_redirected_to commit_attempts_url
  end
end
