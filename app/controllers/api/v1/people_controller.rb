# This controller displays, creates and updates the people that are
# available in the system for the user. All of the endpoints rely on the
# phone number to lookup and create a person in the system. Phone numbers
# should be normalized before use in all cases.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::PeopleController < Api::V1::BaseController
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
