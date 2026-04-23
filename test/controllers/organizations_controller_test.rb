require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_user = User.create!(
      username: "org-user",
      email: "org-user@example.com",
      password: "password123",
      organization_name: "Org User",
      is_organization: true,
      confirmed_at: Time.current
    )
  end

  test "should get index" do
    get organizations_url
    assert_response :success
  end

  test "should get new" do
    get new_organization_url
    assert_response :success
  end

  test "should create organization account" do
    assert_difference("User.count", 1) do
      post organizations_url, params: {
        user: {
          organization_name: "Fresh Org",
          username: "fresh-org",
          email: "fresh-org@example.com",
          password: "password123",
          is_organization: true
        }
      }
    end

    assert_redirected_to root_url
  end

  test "should show organization account" do
    get organization_url(@organization_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_url(@organization_user)
    assert_response :success
  end

  test "should update organization account" do
    patch organization_url(@organization_user), params: {
      user: {
        organization_name: "Updated Org User",
        username: @organization_user.username,
        email: @organization_user.email
      }
    }

    assert_redirected_to user_url(@organization_user)
    assert_equal "Updated Org User", @organization_user.reload.organization_name
  end

  test "should destroy organization account" do
    assert_difference("User.count", -1) do
      delete organization_url(@organization_user)
    end

    assert_redirected_to "/"
  end
end
