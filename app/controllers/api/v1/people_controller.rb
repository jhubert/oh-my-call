# This controller displays, creates and updates the people that are
# available in the system for the user. All of the endpoints rely on the
# phone number to lookup and create a person in the system. Phone numbers
# should be normalized before use in all cases.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::PeopleController < Api::V1::BaseController
  include StandardApiResource
  before_filter :set_instance_from_params, except: %w(index create)

  # The following methods are provided by the StandardApiResource module:
  # index, show, create, update, destroy

  private

  def resource
    current_user.people
  end

  def permitted_params
    params.permit(%w(phone_number fullname nickname active))
  end
end
