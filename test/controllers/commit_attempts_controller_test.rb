require 'test_helper'

class CommitAttemptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commit_attempt = commit_attempts(:one)
    @repository = @commit_attempt.repository
    @user = @repository.user
  end

  test 'should get index' do
    get user_repository_commit_attempts_url(@user, @repository)
    assert_response :success
  end

  test 'should get new' do
    get new_user_repository_commit_attempt_url(@user, @repository)
    assert_response :success
  end

  test 'should create commit attempt' do
    assert_difference('CommitAttempt.count', 1) do
      post user_repository_commit_attempts_url(@user, @repository), params: {
        commit_attempt: {
          message: 'New commit attempt',
          description: 'Testing',
          commit_id: @commit_attempt.commit_id,
          contributor_id: @commit_attempt.contributor_id,
          push_id: @commit_attempt.push_id,
          device_id: @commit_attempt.device_id,
          repository_id: @repository.id
        }
      }
    end

    assert_redirected_to commit_attempt_url(CommitAttempt.last)
  end

  test 'should show commit attempt' do
    get commit_attempt_url(@commit_attempt)
    assert_response :success
  end
end
