require 'test_helper'

class Api::V1::PeopleController::IndexTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :index
  end

  test 'returns an array of people' do
    api_login_user
    perform_request

    assert Array, JSON.parse(response.body).class
    assert response.body.include? Person.first.to_json
  end
end

class Api::V1::PeopleController::ShowTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :show
    @base_params = { id: people(:one).id }
  end

  test 'returns the details of the correct person' do
    api_login_user
    perform_request

    assert_equal people(:one).to_json, response.body
  end
end

class Api::V1::PeopleController::CreateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :post
    @action_name = :create
  end

  test 'creates a new person' do
    api_login_user

    assert_difference 'Person.count' do
      perform_request
    end
  end
end

class Api::V1::PeopleController::UpdateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :put
    @action_name = :update
    @base_params = { id: people(:one).id }
  end

  test 'updates an existing person' do
    api_login_user

    @base_params = { id: people(:one).id, phone_number: '5555551234' }

    perform_request

    assert_equal '5555551234', Person.find(people(:one).id).phone_number
  end
end

class Api::V1::PeopleController::DestroyTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :delete
    @action_name = :destroy
    @base_params = { id: people(:one).id }
    @success_response = :no_content
  end

  test 'removes an existing person' do
    api_login_user

    assert_difference 'Person.count', -1 do
      perform_request
    end
  end
end
