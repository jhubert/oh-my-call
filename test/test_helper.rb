ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

Dir['test/support/**/*rb'].each { |file| require_relative "../#{file}" }

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests
  # in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly
  # in integration tests -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  private

  def api_login_user
    stubbed_token = stub(resource_owner_id: users(:john).id, accessible?: true)
    @controller.stubs(:doorkeeper_token).returns(stubbed_token)
  end
end
