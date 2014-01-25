module ProtectedEndpointTest
  def test_should_return_401_if_unauthenticated
    perform_request
    assert_response :unauthorized
  end

  def test_should_return_200_if_authenticated
    api_login_user
    perform_request
    assert_response @success_response || :success
  end

  private

  def perform_request
    send(@method || :get, @action_name, @base_params || {})
  end
end
