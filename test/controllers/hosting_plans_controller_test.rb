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
      post hosting_plans_url, params: { hosting_plan: { memory: 512, name: "New Hosting Plan", price_per_hour: 0.05, price_per_month: 30, slug: "new-hosting-plan", storage: 2048, transfer: 4096, vcpus: 2 } }
    end

    assert_redirected_to hosting_plans_url
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
    patch hosting_plan_url(@hosting_plan), params: { hosting_plan: { memory: 1024, name: "Updated Hosting Plan", price_per_hour: 0.08, price_per_month: 50, slug: "updated-hosting-plan", storage: 4096, transfer: 8192, vcpus: 4 } }
    assert_redirected_to hosting_plans_url
  end

  test "should destroy hosting_plan" do
    hosting_plan = HostingPlan.create!(
      name: "Disposable Hosting Plan",
      slug: "disposable-hosting-plan",
      memory: 512,
      vcpus: 1,
      storage: 1024,
      transfer: 2048,
      price_per_month: 20
    )

    assert_difference('HostingPlan.count', -1) do
      delete hosting_plan_url(hosting_plan)
    end

    assert_redirected_to hosting_plans_url
  end
end
