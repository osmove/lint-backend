require 'test_helper'

class PlatformsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @platform = platforms(:one)
  end

  test "should get index" do
    get platforms_url
    assert_response :success
  end

  test "should get new" do
    get new_platform_url
    assert_response :success
  end

  test "should create platform" do
    assert_difference('Platform.count') do
      post platforms_url, params: { platform: { framework_id: @platform.framework_id, image: @platform.image, language_id: @platform.language_id, name: "New Platform", slug: "new-platform" } }
    end

    assert_redirected_to platforms_url
  end

  test "should show platform" do
    get platform_url(@platform)
    assert_response :success
  end

  test "should get edit" do
    get edit_platform_url(@platform)
    assert_response :success
  end

  test "should update platform" do
    patch platform_url(@platform), params: { platform: { framework_id: @platform.framework_id, image: @platform.image, language_id: @platform.language_id, name: "Updated Platform", slug: "updated-platform" } }
    assert_redirected_to platforms_url
  end

  test "should destroy platform" do
    platform = Platform.create!(name: "Disposable Platform", slug: "disposable-platform")

    assert_difference('Platform.count', -1) do
      delete platform_url(platform)
    end

    assert_redirected_to platforms_url
  end
end
