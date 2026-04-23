require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
    @team = @membership.team
    @user = @team.user
  end

  test "should get index" do
    get user_team_memberships_url(@user, @team)
    assert_response :success
  end

  test "should get new" do
    get new_user_team_membership_url(@user, @team)
    assert_response :success
  end

  test "should create membership" do
    assert_difference("Membership.count", 1) do
      post user_team_memberships_url(@user, @team), params: {
        membership: {
          username: "teammate",
          origin: "manual",
          origin_url: "https://lint.to",
          avatar_url: "https://lint.to/avatar.png",
          role: "member"
        }
      }
    end

    assert_redirected_to user_team_membership_url(@user, @team, Membership.last)
  end

  test "should show membership" do
    get user_team_membership_url(@user, @team, @membership)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_team_membership_url(@user, @team, @membership)
    assert_response :success
  end

  test "should update membership" do
    patch user_team_membership_url(@user, @team, @membership), params: {
      membership: {
        username: @membership.username,
        origin: @membership.origin,
        origin_url: @membership.origin_url,
        avatar_url: @membership.avatar_url,
        role: "admin"
      }
    }

    assert_redirected_to user_team_membership_url(@user, @team, @membership)
    assert_equal "admin", @membership.reload.role
  end

  test "should destroy membership" do
    membership = Membership.create!(user: users(:two), team: @team, role: "member")

    assert_difference("Membership.count", -1) do
      delete user_team_membership_url(@user, @team, membership)
    end

    assert_redirected_to user_team_memberships_url(@user, @team)
  end
end
