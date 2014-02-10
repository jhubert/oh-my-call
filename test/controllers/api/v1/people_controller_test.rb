require 'test_helper'

class Api::V1::PeopleController::IndexTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :index
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'returns an array' do
    api_login_user
    perform_request

    body = JSON.parse(response.body)
    assert Array, body.class
  end

  test 'renders the index template' do
    api_login_user
    perform_request

    assert_template 'api/v1/people/index'
  end

  test 'renders the expected keys' do
    api_login_user
    perform_request

    expected_keys = %w(
      id phone_number fullname nickname active created_at updated_at
      url response_count call_count situations
    )

    body = JSON.parse(response.body)
    body.each do |person|
      assert_equal expected_keys, person.keys
    end
  end

  test 'only returns people belonging to the authenticated user' do
    api_login_user
    perform_request

    assert_equal [people(:valid)], assigns(:collection).to_a
  end
end

class Api::V1::PeopleController::ShowTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @action_name = :show
    @base_params = { id: people(:valid).id }
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'returns the details of the correct person' do
    api_login_user
    get :show, id: people(:valid).id

    person = JSON.parse(response.body)
    assert_equal people(:valid).id, person['id']
  end

  test 'renders the show template' do
    api_login_user
    get :show, id: people(:valid).id

    assert_template 'api/v1/people/show'
  end

  test 'response includes the expected keys' do
    api_login_user
    get :show, id: people(:valid).id

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

  test 'returns 404 if the person does not belong to the current user' do
    api_login_user
    get :show, id: people(:two).id

    assert_response :not_found
  end
end

class Api::V1::PeopleController::CreateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :post
    @action_name = :create
    @request.env['HTTP_ACCEPT'] = 'application/json'

    @base_params = { phone_number: '5555551234' }
  end

  test 'creates a new person' do
    api_login_user

    assert_difference 'Person.count' do
      post :create, @base_params
    end
  end

  test 'creates a new person belonging to the current user' do
    api_login_user

    post :create, @base_params

    assert_equal users(:john), assigns(:instance).user
  end

  test 'renders the show template' do
    api_login_user
    post :create, @base_params

    assert_template 'api/v1/people/show'
  end

  test 'response includes the expected keys' do
    api_login_user
    post :create, @base_params

    expected_keys = %w(
      id phone_number fullname nickname active created_at updated_at
      url response_count call_count situations
    )
    assert_equal expected_keys, JSON.parse(response.body).keys
  end

  test 'returns the details of the new person' do
    api_login_user
    post :create, @base_params

    person = JSON.parse(response.body)
    assert_equal Person.last.id, person['id']
  end

  test 'returns 422 if the phone number already exists' do
    people(:valid).update_attribute(:phone_number, @base_params[:phone_number])

    api_login_user
    post :create, @base_params
    assert_response :unprocessable_entity
  end
end

class Api::V1::PeopleController::UpdateTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @user = people(:valid)
    @method = :put
    @action_name = :update
    @base_params = { id: @user.id }
    @success_response = :no_content
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'updates an existing person' do
    api_login_user
    put :update, id: @user.id, phone_number: '5555551234'
    assert_equal '5555551234', Person.find(@user.id).phone_number
  end

  test 'returns a 204 no_content response on success' do
    api_login_user
    put :update, id: @user.id, phone_number: '5555551234'
    assert_response :no_content
  end

  test 'returns 404 if the person is not found' do
    api_login_user
    put :update, id: 0
    assert_response :not_found
  end

  test 'returns 404 if the person does not belong to the current user' do
    api_login_user
    put :update, id: people(:two).id

    assert_response :not_found
  end
end

class Api::V1::PeopleController::DestroyTest < ActionController::TestCase
  include ProtectedEndpointTest

  def setup
    @method = :delete
    @action_name = :destroy
    @base_params = { id: people(:valid).id }
    @success_response = :no_content
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  test 'removes an existing person' do
    api_login_user

    assert_difference 'Person.count', -1 do
      delete :destroy, id: people(:valid).id
    end
  end

  test 'returns 404 if the person is not found' do
    api_login_user
    delete :destroy, id: 0
    assert_response :not_found
  end

  test 'returns 404 if the person does not belong to the current user' do
    api_login_user
    delete :destroy, id: people(:two).id

    assert_response :not_found
  end
end
