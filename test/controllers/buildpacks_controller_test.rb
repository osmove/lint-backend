require 'test_helper'

class BuildpacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @buildpack = buildpacks(:one)
  end

  test "should get index" do
    get buildpacks_url
    assert_response :success
  end

  test "should get new" do
    get new_buildpack_url
    assert_response :success
  end

  test "should create buildpack" do
    assert_difference('Buildpack.count') do
      post buildpacks_url, 
           params: { buildpack: { command_id: @buildpack.command_id, git_address: @buildpack.git_address, name: @buildpack.name, 
                                  repository_id: @buildpack.repository_id, user_id: @buildpack.user_id, web_address: @buildpack.web_address } }
    end

    assert_redirected_to buildpack_url(Buildpack.last)
  end

  test "should show buildpack" do
    get buildpack_url(@buildpack)
    assert_response :success
  end

  test "should get edit" do
    get edit_buildpack_url(@buildpack)
    assert_response :success
  end

  test "should update buildpack" do
    patch buildpack_url(@buildpack), 
          params: { buildpack: { command_id: @buildpack.command_id, git_address: @buildpack.git_address, name: @buildpack.name, 
                                 repository_id: @buildpack.repository_id, user_id: @buildpack.user_id, web_address: @buildpack.web_address } }
    assert_redirected_to buildpack_url(@buildpack)
  end

  test "should destroy buildpack" do
    assert_difference('Buildpack.count', -1) do
      delete buildpack_url(@buildpack)
    end

    assert_redirected_to buildpacks_url
  end
end
