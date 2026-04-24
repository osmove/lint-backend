require 'test_helper'

class PolicyRulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @policy_rule = policy_rules(:one)
  end

  test "should get index" do
    get policy_rules_url
    assert_response :success
  end

  test "should get new" do
    get new_policy_rule_url
    assert_response :success
  end

  test "should create policy_rule" do
    assert_difference('PolicyRule.count') do
      post policy_rules_url, 
           params: { policy_rule: { policy_id: @policy_rule.policy_id, position: @policy_rule.position, 
                                    rule_id: @policy_rule.rule_id } }
    end

    assert_redirected_to policy_rule_url(PolicyRule.last)
  end

  test "should show policy_rule" do
    get policy_rule_url(@policy_rule)
    assert_response :success
  end

  test "should get edit" do
    get edit_policy_rule_url(@policy_rule)
    assert_response :success
  end

  test "should update policy_rule" do
    patch policy_rule_url(@policy_rule), 
          params: { policy_rule: { policy_id: @policy_rule.policy_id, position: @policy_rule.position, 
                                   rule_id: @policy_rule.rule_id } }
    assert_redirected_to policy_rule_url(@policy_rule)
  end

  test "should destroy policy_rule" do
    assert_difference('PolicyRule.count', -1) do
      delete policy_rule_url(@policy_rule)
    end

    assert_redirected_to policy_rules_url
  end
end
