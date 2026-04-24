require 'test_helper'

class PoliciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @policy = policies(:one)
  end

  test 'should get index' do
    get user_policies_url(@user)
    assert_response :success
  end

  test 'should get new' do
    get new_user_policy_url(@user)
    assert_response :success
  end

  test 'should create policy' do
    assert_difference('Policy.count', 1) do
      post user_policies_url(@user), params: {
        policy: {
          name: 'New Policy',
          description: 'Policy description'
        }
      }
    end

    assert_redirected_to user_policy_url(@user, Policy.last)
  end

  test 'should show policy' do
    get user_policy_url(@user, @policy)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_policy_url(@user, @policy)
    assert_response :success
  end

  test 'should update policy' do
    patch user_policy_url(@user, @policy), params: {
      policy: {
        name: 'Updated Policy',
        description: @policy.description
      }
    }

    assert_redirected_to user_policy_url(@user, @policy)
    assert_equal 'Updated Policy', @policy.reload.name
  end

  test 'should destroy policy' do
    policy = Policy.create!(name: 'Disposable Policy', description: 'Disposable', user: @user)

    assert_difference('Policy.count', -1) do
      delete user_policy_url(@user, policy)
    end

    assert_redirected_to user_policies_url(@user)
  end
end
