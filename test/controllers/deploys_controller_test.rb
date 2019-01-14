require 'test_helper'

class DeploysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deploy = deploys(:one)
  end

  test "should get index" do
    get deploys_url
    assert_response :success
  end

  test "should get new" do
    get new_deploy_url
    assert_response :success
  end

  test "should create deploy" do
    assert_difference('Deploy.count') do
      post deploys_url, params: { deploy: { repository_id: @deploy.repository_id, user_id: @deploy.user_id } }
    end

    assert_redirected_to deploy_url(Deploy.last)
  end

  test "should show deploy" do
    get deploy_url(@deploy)
    assert_response :success
  end

  test "should get edit" do
    get edit_deploy_url(@deploy)
    assert_response :success
  end

  test "should update deploy" do
    patch deploy_url(@deploy), params: { deploy: { repository_id: @deploy.repository_id, user_id: @deploy.user_id } }
    assert_redirected_to deploy_url(@deploy)
  end

  test "should destroy deploy" do
    assert_difference('Deploy.count', -1) do
      delete deploy_url(@deploy)
    end

    assert_redirected_to deploys_url
  end
end
