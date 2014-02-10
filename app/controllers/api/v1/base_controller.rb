# This is the class that all API controllers inherit from any shared
# configuration or methods should be included here.
class Api::V1::BaseController < ActionController::Base
  doorkeeper_for :all

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
