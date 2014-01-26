# This controller displays the occurances of a situation.
# Every action should have a situation_id parameter available.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::OccurancesController < Api::V1::BaseController
  def index
    render json: {}
  end

  def show
    render json: {}
  end
end
