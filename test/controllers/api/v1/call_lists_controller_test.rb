require 'test_helper'

class Api::V1::CallListsController::ShowTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :show
    @base_params = { situation_id: 1 }
  end
end

class Api::V1::CallListsController::UpdateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :put
    @action_name = :show
    @base_params = { situation_id: 1 }
  end
end

class Api::V1::CallListsController::DestroyTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :delete
    @action_name = :destroy
    @base_params = { situation_id: 1 }
  end
end
