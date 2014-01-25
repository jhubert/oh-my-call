class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.ohmycall.v#{@version}")
  end
end

class ApiSubdomainConstraint
  def matches?(req)
    req.subdomain == 'api'
  end
end

OhMyCall::Application.routes.draw do
  use_doorkeeper

  scope :constraints => ApiSubdomainConstraint.new do
    scope :module => :api, :as => :api, :defaults => { format: 'json' } do
      scope :module => :v1, constraints: ApiConstraints.new(version: 1, default: true) do

        resources :people
        resources :situations do
          resources :occurances, :only => [:index, :show]
          resource :call_list do
            delete ':phone_number' => "call_lists#destroy"
          end
        end

        match "trigger/:id" => "triggers#create", via: [:get, :post]

        root :to => redirect('http://www.ohmycall.com')
        match "*path" => "base#noop", via: [:get, :post]
      end
    end
  end

  root :to => redirect('http://www.ohmycall.com')
end
