require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @repository = repositories(:one)
  end

  test 'should get user index' do
    get user_repositories_url(@user)
    assert_response :success
  end

  test 'should get new' do
    get new_user_repository_url(@user)
    assert_response :success
  end

  test 'should create repository' do
    assert_difference('Repository.count', 1) do
      post user_repositories_url(@user), params: {
        repository: {
          name: 'Gamma Repo',
          slug: 'gamma-repo',
          status: 'Public',
          git_host: 'lint'
        }
      }
    end

    assert_redirected_to user_repository_url(@user, Repository.last)
  end

  test 'should show repository' do
    get user_repository_url(@user, @repository)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_repository_url(@user, @repository)
    assert_response :success
  end

  test 'should update repository' do
    patch user_repository_url(@user, @repository),
          params: {
            repository: {
              name: 'Renamed Repo',
              slug: @repository.slug,
              status: @repository.status
            }
          },
          headers: { 'HTTP_REFERER' => user_repository_url(@user, @repository) }

    assert_redirected_to user_repository_url(@user, @repository)
    assert_equal 'Renamed Repo', @repository.reload.name
  end

  test 'should destroy repository' do
    repository = Repository.create!(name: 'Disposable Repo', slug: 'disposable-repo', status: 'Public', user: @user)

    assert_difference('Repository.count', -1) do
      delete user_repository_url(@user, repository)
    end

    assert_redirected_to root_url
  end
end
