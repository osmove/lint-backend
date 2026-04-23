require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = devices(:one)
  end

  test "should get index" do
    get devices_url
    assert_response :success
  end

  test "should get new" do
    get new_device_url
    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post devices_url, params: { device: { brand: @device.brand, browser: @device.browser, has_lint_connect: @device.has_lint_connect, has_lint_desktop: @device.has_lint_desktop, has_notifications: @device.has_notifications, last_seen: @device.last_seen, model: @device.model, os: @device.os, os_version: @device.os_version, sub_model: @device.sub_model, type: @device.type, user_agent: @device.user_agent, user_id: @device.user_id, uuid: @device.uuid } }
    end

    assert_redirected_to device_url(Device.last)
  end

  test "should show device" do
    get device_url(@device)
    assert_response :success
  end

  test "should get edit" do
    get edit_device_url(@device)
    assert_response :success
  end

  test "should update device" do
    patch device_url(@device), params: { device: { brand: @device.brand, browser: @device.browser, has_lint_connect: @device.has_lint_connect, has_lint_desktop: @device.has_lint_desktop, has_notifications: @device.has_notifications, last_seen: @device.last_seen, model: @device.model, os: @device.os, os_version: @device.os_version, sub_model: @device.sub_model, type: @device.type, user_agent: @device.user_agent, user_id: @device.user_id, uuid: @device.uuid } }
    assert_redirected_to device_url(@device)
  end

  test "should destroy device" do
    assert_difference('Device.count', -1) do
      delete device_url(@device)
    end

    assert_redirected_to devices_url
  end
end
