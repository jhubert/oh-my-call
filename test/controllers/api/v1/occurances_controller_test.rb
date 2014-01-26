require 'test_helper'

class Api::V1::OccurancesController::IndexTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :index
    @base_params = { situation_id: 1 }
  end
end

class Api::V1::OccurancesController::ShowTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :show
    @base_params = { situation_id: 1, id: 1 }
  end
end
