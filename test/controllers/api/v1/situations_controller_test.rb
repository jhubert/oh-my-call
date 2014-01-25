require 'test_helper'

class Api::V1::SituationsController::IndexTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :index
  end
end

class Api::V1::SituationsController::ShowTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :show
    @base_params = { id: 1 }
  end
end

class Api::V1::SituationsController::CreateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :post
    @action_name = :create
  end
end

class Api::V1::SituationsController::UpdateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :patch
    @action_name = :update
    @base_params = { id: 1 }
  end
end

class Api::V1::SituationsController::DestroyTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :delete
    @action_name = :destroy
    @base_params = { id: 1 }
    @success_response = :no_content
  end
end
