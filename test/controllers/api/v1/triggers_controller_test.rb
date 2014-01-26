require 'test_helper'

class Api::V1::TriggersController::CreateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :create
    @base_params = { token: 1 }
  end
end
