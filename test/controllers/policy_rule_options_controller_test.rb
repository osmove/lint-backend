require 'test_helper'

class PolicyRuleOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @policy_rule_option = policy_rule_options(:one)
  end

  test "should get index" do
    get policy_rule_options_url
    assert_response :success
  end

  test "should get new" do
    get new_policy_rule_option_url
    assert_response :success
  end

  test "should create policy_rule_option" do
    assert_difference('PolicyRuleOption.count') do
      post policy_rule_options_url, 
           params: { policy_rule_option: { policy_rule_id: @policy_rule_option.policy_rule_id, 
                                           rule_option_id: @policy_rule_option.rule_option_id, value: @policy_rule_option.value } }
    end

    assert_redirected_to policy_rule_option_url(PolicyRuleOption.last)
  end

  test "should show policy_rule_option" do
    get policy_rule_option_url(@policy_rule_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_policy_rule_option_url(@policy_rule_option)
    assert_response :success
  end

  test "should update policy_rule_option" do
    patch policy_rule_option_url(@policy_rule_option), 
          params: { policy_rule_option: { policy_rule_id: @policy_rule_option.policy_rule_id, 
                                          rule_option_id: @policy_rule_option.rule_option_id, value: @policy_rule_option.value } }
    assert_redirected_to policy_rule_option_url(@policy_rule_option)
  end

  test "should destroy policy_rule_option" do
    assert_difference('PolicyRuleOption.count', -1) do
      delete policy_rule_option_url(@policy_rule_option)
    end

    assert_redirected_to policy_rule_options_url
  end
end
