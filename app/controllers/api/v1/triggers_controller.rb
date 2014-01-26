# This controller provides the endpoint for triggering a situation. It is the
# only endpoint that doesn't require authentication to hit. Instead it requires
# a situation token that is private for the developers only.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::TriggersController < Api::V1::BaseController
  def create
    head :accepted
  end
end
