require 'test_helper'

class LintersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @linter = linters(:one)
  end

  test "should get index" do
    get linters_url
    assert_response :success
  end

  test "should get new" do
    get new_linter_url
    assert_response :success
  end

  test "should create linter" do
    assert_difference('Linter.count') do
      post linters_url, params: { linter: { name: @linter.name } }
    end

    assert_redirected_to linter_url(Linter.last)
  end

  test "should show linter" do
    get linter_url(@linter)
    assert_response :success
  end

  test "should get edit" do
    get edit_linter_url(@linter)
    assert_response :success
  end

  test "should update linter" do
    patch linter_url(@linter), params: { linter: { name: @linter.name } }
    assert_redirected_to linter_url(@linter)
  end

  test "should destroy linter" do
    linter = Linter.create!(name: "Disposable Linter", command: "disposable")

    assert_difference('Linter.count', -1) do
      delete linter_url(linter)
    end

    assert_redirected_to linters_url
  end
end
