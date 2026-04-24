require 'test_helper'

class EncryptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @encryption = encryptions(:one)
  end

  test 'should get index' do
    get encryptions_url
    assert_response :success
  end

  test 'should get new' do
    get new_encryption_url
    assert_response :success
  end

  test 'should create encryption' do
    assert_difference('Encryption.count') do
      post encryptions_url,
           params: { encryption: { cypher_name: @encryption.cypher_name, document_id: @encryption.document_id,
                                   repository_id: @encryption.repository_id, status: @encryption.status, user_id: @encryption.user_id } }
    end

    assert_redirected_to encryption_url(Encryption.last)
  end

  test 'should show encryption' do
    get encryption_url(@encryption)
    assert_response :success
  end

  test 'should get edit' do
    get edit_encryption_url(@encryption)
    assert_response :success
  end

  test 'should update encryption' do
    patch encryption_url(@encryption),
          params: { encryption: { cypher_name: @encryption.cypher_name, document_id: @encryption.document_id,
                                  repository_id: @encryption.repository_id, status: @encryption.status, user_id: @encryption.user_id } }
    assert_redirected_to encryption_url(@encryption)
  end

  test 'should destroy encryption' do
    assert_difference('Encryption.count', -1) do
      delete encryption_url(@encryption)
    end

    assert_redirected_to encryptions_url
  end
end
