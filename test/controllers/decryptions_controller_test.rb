require 'test_helper'

class DecryptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @decryption = decryptions(:one)
  end

  test "should get index" do
    get decryptions_url
    assert_response :success
  end

  test "should get new" do
    get new_decryption_url
    assert_response :success
  end

  test "should create decryption" do
    assert_difference('Decryption.count') do
      post decryptions_url, 
           params: { decryption: { cypher_name: @decryption.cypher_name, document_id: @decryption.document_id, 
                                   repository_id: @decryption.repository_id, status: @decryption.status, user_id: @decryption.user_id } }
    end

    assert_redirected_to decryption_url(Decryption.last)
  end

  test "should show decryption" do
    get decryption_url(@decryption)
    assert_response :success
  end

  test "should get edit" do
    get edit_decryption_url(@decryption)
    assert_response :success
  end

  test "should update decryption" do
    patch decryption_url(@decryption), 
          params: { decryption: { cypher_name: @decryption.cypher_name, document_id: @decryption.document_id, 
                                  repository_id: @decryption.repository_id, status: @decryption.status, user_id: @decryption.user_id } }
    assert_redirected_to decryption_url(@decryption)
  end

  test "should destroy decryption" do
    assert_difference('Decryption.count', -1) do
      delete decryption_url(@decryption)
    end

    assert_redirected_to decryptions_url
  end
end
