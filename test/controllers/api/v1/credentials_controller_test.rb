require 'test_helper'

class Api::V1::CredentialsControllerTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :me
  end

  test 'should return the user details' do
    api_login_user
    get :me
    body = JSON.parse(response.body)
    assert_equal %w(id sign_in_count), body.keys
    assert_equal 1, body['id']
  end
end
