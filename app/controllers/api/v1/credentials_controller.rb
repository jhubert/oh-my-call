# This controller provides the endpoint for getting the user details of
# the currently logged in user. Note that you should only respond with
# information you want the user to be able to see
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::CredentialsController < Api::V1::BaseController
  def me
    render json: { id: 1, sign_in_count: 0 }
  end
end
