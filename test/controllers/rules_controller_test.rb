require 'test_helper'

class RulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rule = rules(:one)
  end

  test "should get index" do
    get rules_url
    assert_response :success
  end

  test "should get new" do
    get new_rule_url
    assert_response :success
  end

  test "should create rule" do
    assert_difference('Rule.count') do
      post rules_url, params: { rule: { description: @rule.description, framework_id: @rule.framework_id, language_id: @rule.language_id, linter_id: @rule.linter_id, name: "New Rule", parent_id: @rule.parent_id, platform_id: @rule.platform_id, status: @rule.status, type: @rule.type } }
    end

    assert_redirected_to rule_url(Rule.last)
  end

  test "should show rule" do
    get rule_url(@rule)
    assert_response :success
  end

  test "should get edit" do
    get edit_rule_url(@rule)
    assert_response :success
  end

  test "should update rule" do
    patch rule_url(@rule), params: { rule: { description: @rule.description, framework_id: @rule.framework_id, language_id: @rule.language_id, linter_id: @rule.linter_id, name: "Updated Rule", parent_id: @rule.parent_id, platform_id: @rule.platform_id, status: @rule.status, type: @rule.type } }
    assert_redirected_to rule_url(@rule)
  end

  test "should destroy rule" do
    rule = Rule.create!(
      name: "Disposable Rule",
      description: "Disposable",
      status: "active",
      language: languages(:one),
      framework: frameworks(:one),
      platform: platforms(:one),
      linter: linters(:one)
    )

    assert_difference('Rule.count', -1) do
      delete rule_url(rule)
    end

    assert_redirected_to rules_url
  end
end
