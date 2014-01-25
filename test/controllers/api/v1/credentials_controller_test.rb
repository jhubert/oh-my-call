require 'test_helper'

class Api::V1::CredentialsControllerTest < ActionController::TestCase
  test "should return 401 if unauthenticated" do
    get :me
    assert_response :unauthorized
  end

  test "should return 200 if authenticated" do
    api_login_user
    get :me
    assert_response :success
  end

  test "should return the user details" do
    api_login_user
    get :me
    body = JSON.parse(response.body)
    assert_equal ['id', 'sign_in_count'], body.keys
    assert_equal 1, body['id']
  end

  private

  def api_login_user
    @controller.stubs(:doorkeeper_token).returns(stub(resource_owner_id: 1, accessible?: true))
  end
end
