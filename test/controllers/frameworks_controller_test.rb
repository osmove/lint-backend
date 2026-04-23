require 'test_helper'

class FrameworksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @framework = frameworks(:one)
  end

  test "should get index" do
    get frameworks_url
    assert_response :success
  end

  test "should get new" do
    get new_framework_url
    assert_response :success
  end

  test "should create framework" do
    assert_difference('Framework.count') do
      post frameworks_url, params: { framework: { name: "New Framework", slug: "new-framework" } }
    end

    assert_redirected_to framework_url(Framework.last)
  end

  test "should show framework" do
    get framework_url(@framework)
    assert_response :success
  end

  test "should get edit" do
    get edit_framework_url(@framework)
    assert_response :success
  end

  test "should update framework" do
    patch framework_url(@framework), params: { framework: { name: "Updated Framework", slug: "updated-framework" } }
    assert_redirected_to framework_url(@framework)
  end

  test "should destroy framework" do
    framework = Framework.create!(name: "Disposable Framework", slug: "disposable-framework")

    assert_difference('Framework.count', -1) do
      delete framework_url(framework)
    end

    assert_redirected_to frameworks_url
  end
end
