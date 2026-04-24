require 'test_helper'

class PushesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @push = pushes(:one)
  end

  test 'should get index' do
    get pushes_url
    assert_response :success
  end

  test 'should get new' do
    get new_push_url
    assert_response :success
  end

  test 'should create push' do
    assert_difference('Push.count') do
      post pushes_url, params: { push: { repository_id: @push.repository_id, user_id: @push.user_id } }
    end

    assert_redirected_to push_url(Push.last)
  end

  test 'should show push' do
    get push_url(@push)
    assert_response :success
  end

  test 'should get edit' do
    get edit_push_url(@push)
    assert_response :success
  end

  test 'should update push' do
    patch push_url(@push), params: { push: { repository_id: @push.repository_id, user_id: @push.user_id } }
    assert_redirected_to push_url(@push)
  end

  test 'should destroy push' do
    push = Push.create!(repository: repositories(:one), user: users(:one))

    assert_difference('Push.count', -1) do
      delete push_url(push)
    end

    assert_redirected_to pushes_url
  end
end
