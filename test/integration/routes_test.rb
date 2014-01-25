require 'test_helper'

class ApiRoutesTest < ActionDispatch::IntegrationTest
  test "root redirects to main website" do
    get endpoint("/")
    assert_redirected_to "http://www.ohmycall.com"
  end

  test "a missing route maps to base#no_op" do
    assert_routing endpoint("/random-missing-endpoint"), {
      format: "json", controller: "api/v1/base",
      action: "noop", path: "random-missing-endpoint"
    }
  end

  test "me route" do
    assert_routing({ method: 'get', path: endpoint("/me") }, {controller: "api/v1/credentials", action: "me", format: "json" })
  end

  test "people routes" do
    assert_rest_endpoints('people')
  end

  test "situation routes" do
    assert_rest_endpoints('situations')
  end

  test "occurance routes" do
    assert_routing endpoint("/situations/1/occurances"), {controller: "api/v1/occurances", action: "index", format: "json", situation_id: "1" }
    assert_routing endpoint("/situations/1/occurances/key"), {controller: "api/v1/occurances", action: "show", format: "json", situation_id: "1", id: "key" }
  end

  test "call list routes" do
    assert_routing endpoint("/situations/1/call_list"), {controller: "api/v1/call_lists", action: "show", format: "json", situation_id: "1" }
    assert_routing({ method: 'put', path: endpoint("/situations/1/call_list") }, {controller: "api/v1/call_lists", action: "update", format: "json", situation_id: "1" })
    assert_routing({ method: 'patch', path: endpoint("/situations/1/call_list") }, {controller: "api/v1/call_lists", action: "update", format: "json", situation_id: "1" })
    assert_routing({ method: 'delete', path: endpoint("/situations/1/call_list/key") }, {controller: "api/v1/call_lists", action: "destroy", format: "json", situation_id: "1", phone_number: "key" })
  end

  test "trigger routes" do
    assert_routing({ method: 'get', path: endpoint("/trigger/key") }, {controller: "api/v1/triggers", action: "create", format: "json", id: "key" })
    assert_routing({ method: 'post', path: endpoint("/trigger/key") }, {controller: "api/v1/triggers", action: "create", format: "json", id: "key" })
  end

  private

  def endpoint(path="")
    "http://api.example.com#{path}"
  end

  def assert_rest_endpoints(name, options={})
    assert_routing endpoint("/#{options[:prefix]}#{name}"), {controller: "api/v1/#{name}", action: "index", format: "json" }
    assert_routing endpoint("/#{options[:prefix]}#{name}/key"), {controller: "api/v1/#{name}", action: "show", format: "json", id: "key" }
    assert_routing({ method: 'post', path: endpoint("/#{options[:prefix]}#{name}") }, {controller: "api/v1/#{name}", action: "create", format: "json" })
    assert_routing({ method: 'put', path: endpoint("/#{options[:prefix]}#{name}/key") }, {controller: "api/v1/#{name}", action: "update", format: "json", id: "key" })
    assert_routing({ method: 'delete', path: endpoint("/#{options[:prefix]}#{name}/key") }, {controller: "api/v1/#{name}", action: "destroy", format: "json", id: "key" })
  end
end
