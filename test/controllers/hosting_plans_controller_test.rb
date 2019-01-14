require 'test_helper'

class HostingPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hosting_plan = hosting_plans(:one)
  end

  test "should get index" do
    get hosting_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_hosting_plan_url
    assert_response :success
  end

  test "should create hosting_plan" do
    assert_difference('HostingPlan.count') do
      post hosting_plans_url, params: { hosting_plan: { memory: @hosting_plan.memory, name: @hosting_plan.name, price_per_hour: @hosting_plan.price_per_hour, price_per_month: @hosting_plan.price_per_month, slug: @hosting_plan.slug, storage: @hosting_plan.storage, vcpus: @hosting_plan.vcpus } }
    end

    assert_redirected_to hosting_plan_url(HostingPlan.last)
  end

  test "should show hosting_plan" do
    get hosting_plan_url(@hosting_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_hosting_plan_url(@hosting_plan)
    assert_response :success
  end

  test "should update hosting_plan" do
    patch hosting_plan_url(@hosting_plan), params: { hosting_plan: { memory: @hosting_plan.memory, name: @hosting_plan.name, price_per_hour: @hosting_plan.price_per_hour, price_per_month: @hosting_plan.price_per_month, slug: @hosting_plan.slug, storage: @hosting_plan.storage, vcpus: @hosting_plan.vcpus } }
    assert_redirected_to hosting_plan_url(@hosting_plan)
  end

  test "should destroy hosting_plan" do
    assert_difference('HostingPlan.count', -1) do
      delete hosting_plan_url(@hosting_plan)
    end

    assert_redirected_to hosting_plans_url
  end
end
