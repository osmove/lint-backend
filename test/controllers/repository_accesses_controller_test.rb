require 'test_helper'

class RepositoryAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @user = @repository.user
    @repository_access = repository_accesses(:one)
  end

  test "should get index" do
    get user_repository_repository_accesses_url(@user, @repository)
    assert_response :success
  end

  test "should get new" do
    get new_user_repository_repository_access_url(@user, @repository)
    assert_response :success
  end

  test "should create repository access" do
    assert_difference("RepositoryAccess.count", 1) do
      post user_repository_repository_accesses_url(@user, @repository), params: {
        repository_access: {
          role: "viewer",
          status: "active",
          user_id: users(:two).id
        }
      }
    end

    assert_redirected_to user_repository_repository_access_url(@user, @repository, RepositoryAccess.last)
  end

  test "should show repository access" do
    get user_repository_repository_access_url(@user, @repository, @repository_access)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_repository_repository_access_url(@user, @repository, @repository_access)
    assert_response :success
  end

  test "should update repository access" do
    patch user_repository_repository_access_url(@user, @repository, @repository_access), params: {
      repository_access: {
        role: "maintainer",
        status: "active",
        user_id: @repository_access.user_id
      }
    }

    assert_redirected_to user_repository_repository_access_url(@user, @repository, @repository_access)
    assert_equal "maintainer", @repository_access.reload.role
  end

  test "should destroy repository access" do
    repository_access = RepositoryAccess.create!(repository: @repository, user: users(:two), role: "viewer", 
                                                 status: "active")

    assert_difference("RepositoryAccess.count", -1) do
      delete user_repository_repository_access_url(@user, @repository, repository_access)
    end

    assert_redirected_to user_repository_repository_accesses_url(@user, @repository)
  end
end
