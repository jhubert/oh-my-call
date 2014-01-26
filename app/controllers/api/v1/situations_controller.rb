# This controller provides the endpoints for viewing and setting up
# situations, the core functionality of the application.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::SituationsController < Api::V1::BaseController
  def index
    render json: {}
  end

  def show
    render json: {}
  end

  def create
    render json: {}
  end

  def update
    render json: {}
  end

  def destroy
    head :no_content
  end
end
