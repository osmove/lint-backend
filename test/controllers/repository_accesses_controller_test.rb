require 'test_helper'

class RepositoryAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository_access = repository_accesses(:one)
  end

  test "should get index" do
    get repository_accesses_url
    assert_response :success
  end

  test "should get new" do
    get new_repository_access_url
    assert_response :success
  end

  test "should create repository_access" do
    assert_difference('RepositoryAccess.count') do
      post repository_accesses_url, params: { repository_access: { repository_id: @repository_access.repository_id, role: @repository_access.role, status: @repository_access.status, user_id: @repository_access.user_id } }
    end

    assert_redirected_to repository_access_url(RepositoryAccess.last)
  end

  test "should show repository_access" do
    get repository_access_url(@repository_access)
    assert_response :success
  end

  test "should get edit" do
    get edit_repository_access_url(@repository_access)
    assert_response :success
  end

  test "should update repository_access" do
    patch repository_access_url(@repository_access), params: { repository_access: { repository_id: @repository_access.repository_id, role: @repository_access.role, status: @repository_access.status, user_id: @repository_access.user_id } }
    assert_redirected_to repository_access_url(@repository_access)
  end

  test "should destroy repository_access" do
    assert_difference('RepositoryAccess.count', -1) do
      delete repository_access_url(@repository_access)
    end

    assert_redirected_to repository_accesses_url
  end
end
