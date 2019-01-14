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
      post plans_url, params: { plan: { description: @plan.description, max_repositories: @plan.max_repositories, max_storage: @plan.max_storage, max_users: @plan.max_users, name: @plan.name, price_per_month: @plan.price_per_month, price_per_year: @plan.price_per_year, slug: @plan.slug } }
    end

    assert_redirected_to plan_url(Plan.last)
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
    patch plan_url(@plan), params: { plan: { description: @plan.description, max_repositories: @plan.max_repositories, max_storage: @plan.max_storage, max_users: @plan.max_users, name: @plan.name, price_per_month: @plan.price_per_month, price_per_year: @plan.price_per_year, slug: @plan.slug } }
    assert_redirected_to plan_url(@plan)
  end

  test "should destroy plan" do
    assert_difference('Plan.count', -1) do
      delete plan_url(@plan)
    end

    assert_redirected_to plans_url
  end
end
