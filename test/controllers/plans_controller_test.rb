require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plan = plans(:one)
  end

  test "should get index" do
    get plans_url
    assert_response :success
  end

  test "should get new" do
    get new_plan_url
    assert_response :success
  end

  test "should create plan" do
    assert_difference('Plan.count') do
      post plans_url, params: { plan: { description: @plan.description, max_repositories: @plan.max_repositories, max_storage: @plan.max_storage, max_users: @plan.max_users, name: "New Plan", price_per_month: 30, price_per_year: 300, slug: "new-plan" } }
    end

    assert_redirected_to plans_url
  end

  test "should show plan" do
    get plan_url(@plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_plan_url(@plan)
    assert_response :success
  end

  test "should update plan" do
    patch plan_url(@plan), params: { plan: { description: @plan.description, max_repositories: @plan.max_repositories, max_storage: @plan.max_storage, max_users: @plan.max_users, name: "Updated Plan", price_per_month: 40, price_per_year: 400, slug: "updated-plan" } }
    assert_redirected_to plans_url
  end

  test "should destroy plan" do
    assert_difference('Plan.count', -1) do
      delete plan_url(@plan)
    end

    assert_redirected_to plans_url
  end
end
