require 'test_helper'

class DependanciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dependancy = dependancies(:one)
  end

  test 'should get index' do
    get dependancies_url
    assert_response :success
  end

  test 'should get new' do
    get new_dependancy_url
    assert_response :success
  end

  test 'should create dependancy' do
    assert_difference('Dependancy.count') do
      post dependancies_url,
           params: { dependancy: { name: @dependancy.name, repository_id: @dependancy.repository_id, slug: @dependancy.slug,
                                   user_id: @dependancy.user_id } }
    end

    assert_redirected_to dependancy_url(Dependancy.last)
  end

  test 'should show dependancy' do
    get dependancy_url(@dependancy)
    assert_response :success
  end

  test 'should get edit' do
    get edit_dependancy_url(@dependancy)
    assert_response :success
  end

  test 'should update dependancy' do
    patch dependancy_url(@dependancy),
          params: { dependancy: { name: @dependancy.name, repository_id: @dependancy.repository_id, slug: @dependancy.slug,
                                  user_id: @dependancy.user_id } }
    assert_redirected_to dependancy_url(@dependancy)
  end

  test 'should destroy dependancy' do
    assert_difference('Dependancy.count', -1) do
      delete dependancy_url(@dependancy)
    end

    assert_redirected_to dependancies_url
  end
end
