require 'test_helper'

class PullsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pull = pulls(:one)
  end

  test 'should get index' do
    get pulls_url
    assert_response :success
  end

  test 'should get new' do
    get new_pull_url
    assert_response :success
  end

  test 'should create pull' do
    assert_difference('Pull.count') do
      post pulls_url, params: { pull: { repository_id: @pull.repository_id, user_id: @pull.user_id } }
    end

    assert_redirected_to pull_url(Pull.last)
  end

  test 'should show pull' do
    get pull_url(@pull)
    assert_response :success
  end

  test 'should get edit' do
    get edit_pull_url(@pull)
    assert_response :success
  end

  test 'should update pull' do
    patch pull_url(@pull), params: { pull: { repository_id: @pull.repository_id, user_id: @pull.user_id } }
    assert_redirected_to pull_url(@pull)
  end

  test 'should destroy pull' do
    assert_difference('Pull.count', -1) do
      delete pull_url(@pull)
    end

    assert_redirected_to pulls_url
  end
end
