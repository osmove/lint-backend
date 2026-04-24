require 'test_helper'

class PolicyChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @policy_check = policy_checks(:one)
  end

  test 'should get index' do
    get policy_checks_url
    assert_response :success
  end

  test 'should get new' do
    get new_policy_check_url
    assert_response :success
  end

  test 'should create policy_check' do
    assert_difference('PolicyCheck.count') do
      post policy_checks_url,
           params: { policy_check: { commit_attempt_id: @policy_check.commit_attempt_id,
                                     contributor_id: @policy_check.contributor_id, device_id: @policy_check.device_id, name: @policy_check.name, passed: @policy_check.passed, policy_id: @policy_check.policy_id, push_id: @policy_check.push_id, repository_id: @policy_check.repository_id, user_id: @policy_check.user_id } }
    end

    assert_redirected_to policy_check_url(PolicyCheck.last)
  end

  test 'should show policy_check' do
    get policy_check_url(@policy_check)
    assert_response :success
  end

  test 'should get edit' do
    get edit_policy_check_url(@policy_check)
    assert_response :success
  end

  test 'should update policy_check' do
    patch policy_check_url(@policy_check),
          params: { policy_check: { commit_attempt_id: @policy_check.commit_attempt_id,
                                    contributor_id: @policy_check.contributor_id, device_id: @policy_check.device_id, name: @policy_check.name, passed: @policy_check.passed, policy_id: @policy_check.policy_id, push_id: @policy_check.push_id, repository_id: @policy_check.repository_id, user_id: @policy_check.user_id } }
    assert_redirected_to policy_check_url(@policy_check)
  end

  test 'should destroy policy_check' do
    assert_difference('PolicyCheck.count', -1) do
      delete policy_check_url(@policy_check)
    end

    assert_redirected_to policy_checks_url
  end
end
