# This controller displays, creates and updates the people that are
# available in the system for the user. All of the endpoints rely on the
# phone number to lookup and create a person in the system. Phone numbers
# should be normalized before use in all cases.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::PeopleController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  respond_to :json

  def index
    @people = Person.all
    respond_with :api, @people
  end

  def show
    @person = Person.find(params[:id])
    respond_with :api, @person
  end

  def create
    @person = Person.create(people_params)
    respond_with :api, @person, template: 'api/v1/people/show'
  end

  def update
    Person.find(params[:id]).update_attributes(people_params)

    head :no_content
  end

  def destroy
    Person.destroy(params[:id])

    head :no_content
  end

  private

  def people_params
    params.permit(%w(phone_number fullname nickname active))
  end

  def handle_not_found
    head :not_found
  end
end
