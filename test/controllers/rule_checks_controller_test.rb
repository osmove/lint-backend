require 'test_helper'

class RuleChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rule_check = rule_checks(:one)
  end

  test "should get index" do
    get rule_checks_url
    assert_response :success
  end

  test "should get new" do
    get new_rule_check_url
    assert_response :success
  end

  test "should create rule_check" do
    assert_difference('RuleCheck.count') do
      post rule_checks_url, params: { rule_check: { contributor_id: @rule_check.contributor_id, device_id: @rule_check.device_id, language_id: @rule_check.language_id, name: @rule_check.name, passed: @rule_check.passed, policy_check_id: @rule_check.policy_check_id, push_id: @rule_check.push_id, repository_id: @rule_check.repository_id, rule_id: @rule_check.rule_id, user_id: @rule_check.user_id } }
    end

    assert_redirected_to rule_check_url(RuleCheck.last)
  end

  test "should show rule_check" do
    get rule_check_url(@rule_check)
    assert_response :success
  end

  test "should get edit" do
    get edit_rule_check_url(@rule_check)
    assert_response :success
  end

  test "should update rule_check" do
    patch rule_check_url(@rule_check), params: { rule_check: { contributor_id: @rule_check.contributor_id, device_id: @rule_check.device_id, language_id: @rule_check.language_id, name: @rule_check.name, passed: @rule_check.passed, policy_check_id: @rule_check.policy_check_id, push_id: @rule_check.push_id, repository_id: @rule_check.repository_id, rule_id: @rule_check.rule_id, user_id: @rule_check.user_id } }
    assert_redirected_to rule_check_url(@rule_check)
  end

  test "should destroy rule_check" do
    assert_difference('RuleCheck.count', -1) do
      delete rule_check_url(@rule_check)
    end

    assert_redirected_to rule_checks_url
  end
end
