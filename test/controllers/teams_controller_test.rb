require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @team = teams(:one)
  end

  test 'should get index' do
    get user_teams_url(@user)
    assert_response :success
  end

  test 'should get new' do
    get new_user_team_url(@user)
    assert_response :success
  end

  test 'should create team' do
    assert_difference('Team.count', 1) do
      post user_teams_url(@user), params: {
        team: {
          avatar_url: @team.avatar_url,
          description: @team.description,
          name: 'Fresh Team',
          team_id: @team.id
        }
      }
    end

    assert_redirected_to user_team_url(@user, Team.last)
  end

  test 'should show team' do
    get user_team_url(@user, @team)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_team_url(@user, @team)
    assert_response :success
  end

  test 'should update team' do
    patch user_team_url(@user, @team), params: {
      team: {
        avatar_url: @team.avatar_url,
        description: 'Updated team description',
        name: @team.name,
        team_id: @team.parent&.id
      }
    }

    assert_redirected_to team_url(@team)
    assert_equal 'Updated team description', @team.reload.description
  end

  test 'should destroy team' do
    team = Team.create!(name: 'Disposable Team', user: @user)

    assert_difference('Team.count', -1) do
      delete user_team_url(@user, team)
    end

    assert_redirected_to teams_url
  end
end
