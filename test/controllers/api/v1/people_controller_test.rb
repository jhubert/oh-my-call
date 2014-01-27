require 'test_helper'

class Api::V1::PeopleController::IndexTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :index
    @request.env['HTTP_ACCEPT'] = 'application/json'
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
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'returns the details of the correct person' do
    api_login_user
    get :show, id: people(:one).id

    person = JSON.parse(response.body)
    assert_equal people(:one).id, person['id']
  end

  test 'renders the show template' do
    api_login_user
    get :show, id: people(:one).id

    assert_template 'api/v1/people/show'
  end

  test 'response includes the expected keys' do
    api_login_user
    get :show, id: people(:one).id

    expected_keys = %w(
      id phone_number fullname nickname active created_at updated_at
      url response_count call_count situations
    )
    assert_equal expected_keys, JSON.parse(response.body).keys
  end

  test 'returns 404 if the person is not found' do
    api_login_user
    get :show, id: 0

    assert_response :not_found
  end
end

class Api::V1::PeopleController::CreateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :post
    @action_name = :create
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'creates a new person' do
    api_login_user

    assert_difference 'Person.count' do
      post :create, {}
    end
  end

  test 'renders the show template' do
    api_login_user
    post :create, {}

    assert_template 'api/v1/people/show'
  end

  test 'response includes the expected keys' do
    api_login_user
    post :create, {}

    expected_keys = %w(
      id phone_number fullname nickname active created_at updated_at
      url response_count call_count situations
    )
    assert_equal expected_keys, JSON.parse(response.body).keys
  end

  test 'returns the details of the new person' do
    api_login_user
    post :create, {}

    person = JSON.parse(response.body)
    assert_equal Person.last.id, person['id']
  end
end

class Api::V1::PeopleController::UpdateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :put
    @action_name = :update
    @base_params = { id: people(:one).id }
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'updates an existing person' do
    api_login_user
    put :update, id: people(:one).id, phone_number: '5555551234'
    assert_equal '5555551234', Person.find(people(:one).id).phone_number
  end

  test 'returns 404 if the person is not found' do
    api_login_user
    put :update, id: 0
    assert_response :not_found
  end
end

class Api::V1::PeopleController::DestroyTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :delete
    @action_name = :destroy
    @base_params = { id: people(:one).id }
    @success_response = :no_content
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'removes an existing person' do
    api_login_user

    assert_difference 'Person.count', -1 do
      delete :destroy, id: people(:one).id
    end
  end

  test 'returns 404 if the person is not found' do
    api_login_user
    delete :destroy, id: 0
    assert_response :not_found
  end
end
