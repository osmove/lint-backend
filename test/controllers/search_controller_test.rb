require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test 'should get search' do
    get search_search_url
    assert_response :success
  end

  test 'should get search_repositories' do
    get search_search_repositories_url
    assert_response :success
  end

  test 'should get search_users' do
    get search_search_users_url
    assert_response :success
  end
end
