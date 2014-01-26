# rubocop:disable LineLength, BracesAroundHashParameters

require 'test_helper'

class ApiRoutesTest < ActionDispatch::IntegrationTest
  test 'root redirects to main website' do
    get endpoint('/')
    assert_redirected_to 'http://www.ohmycall.com'
  end

  test 'a missing route maps to base#no_op' do
    check :get, '/missing', { format: 'json', controller: 'api/v1/base', action: 'noop', path: 'missing' }
  end

  test 'me route' do
    check :get, '/me', { controller: 'api/v1/credentials', action: 'me' }
  end

  test 'people routes' do
    assert_rest_endpoints('people')
  end

  test 'situation routes' do
    assert_rest_endpoints('situations')
  end

  test 'occurance routes' do
    check :get, '/situations/1/occurances', { controller: 'api/v1/occurances', action: 'index', situation_id: '1' }
    check :get, '/situations/1/occurances/key', { controller: 'api/v1/occurances', action: 'show', situation_id: '1', id: 'key' }
  end

  test 'call list routes' do
    check :get, '/situations/1/call_list', { controller: 'api/v1/call_lists', action: 'show', situation_id: '1' }
    check :put, '/situations/1/call_list', { controller: 'api/v1/call_lists', action: 'update', situation_id: '1' }
    check :patch, '/situations/1/call_list', { controller: 'api/v1/call_lists', action: 'update', situation_id: '1' }
    check :delete, '/situations/1/call_list/key', { controller: 'api/v1/call_lists', action: 'destroy', situation_id: '1', phone_number: 'key' }
  end

  test 'trigger routes' do
    check :get, '/trigger/key', { controller: 'api/v1/triggers', action: 'create', token: 'key' }
    check :post, '/trigger/key', { controller: 'api/v1/triggers', action: 'create', token: 'key' }
  end

  private

  def endpoint(path = '')
    "http://api.example.com#{path}"
  end

  def assert_rest_endpoints(name, options = {})
    check :get, "/#{options[:prefix]}#{name}", { controller: "api/v1/#{name}", action: 'index' }
    check :get, "/#{options[:prefix]}#{name}/key", { controller: "api/v1/#{name}", action: 'show', id: 'key' }
    check :post, "/#{options[:prefix]}#{name}", { controller: "api/v1/#{name}", action: 'create' }
    check :put, "/#{options[:prefix]}#{name}/key", { controller: "api/v1/#{name}", action: 'update', id: 'key' }
    check :delete, "/#{options[:prefix]}#{name}/key", { controller: "api/v1/#{name}", action: 'destroy', id: 'key' }
  end

  def check(method, path, result)
    assert_routing({
      method: method,
      path: endpoint(path)
    }, {
      format: 'json'
    }.merge(result))
  end
end
