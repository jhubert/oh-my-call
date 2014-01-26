# Allows the version to be set based on the accept header
# so that people can use either a beta version or an older
# version of the API that isn't the current version.
class ApiConstraints
  def initialize(options = {})
    @version = options[:version] || 1
    @default = options[:default] || true
  end

  def matches?(req)
    @default || req.headers['Accept'].include?(version_string)
  end

  def version_string
    "application/vnd.ohmycall.v#{@version}"
  end
end

# This constraint makes sure that the api is only
# accessed from the api.xxxx.xxx subdomain
class ApiSubdomainConstraint
  def matches?(req)
    req.subdomain == 'api'
  end
end

OhMyCall::Application.routes.draw do
  use_doorkeeper
  devise_for :users

  scope constraints: ApiSubdomainConstraint.new do
    scope module: :api, as: :api, defaults: { format: 'json' } do
      scope module: :v1, constraints: ApiConstraints.new do

        resources :people
        resources :situations do
          resources :occurances, only: [:index, :show]
          resource :call_list do
            delete ':phone_number' => 'call_lists#destroy'
          end
        end

        match 'trigger/:token' => 'triggers#create', via: [:get, :post]

        get 'me' => 'credentials#me'

        root to: redirect('http://www.ohmycall.com')
        match '*path' => 'base#noop', via: [:get, :post]
      end
    end
  end

  root to: 'static#index'
end
