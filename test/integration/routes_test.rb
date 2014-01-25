require 'test_helper'

class ApiRoutesTest < ActionDispatch::IntegrationTest
  test "root redirects to main website" do
    get endpoint("/")
    assert_redirected_to "http://www.ohmycall.com"
  end

  private

  def endpoint(path="")
    "http://api.example.com#{path}"
  end
end
