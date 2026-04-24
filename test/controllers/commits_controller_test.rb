require 'test_helper'

class CommitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @user = @repository.user
    @commit = commits(:one)
  end

  test 'should get repository commit index' do
    get user_repository_commits_url(@user, @repository)
    assert_response :success
  end

  test 'should show repository commit' do
    get user_repository_commit_url(@user, @repository, @commit)
    assert_response :success
  end
end
