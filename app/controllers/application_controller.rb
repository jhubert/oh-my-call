# The core application controller, although none of the API endpoints
# inherit from this controller. For the API endpoints, you'll want to
# check out api/v1/base_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
