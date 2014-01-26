# This controller handles the display and updating of a call list for a
# situation. Every action should have a situation_id parameter available.
#
# Routes tests are handled in test/integration/routes_test.rb
class Api::V1::CallListsController < Api::V1::BaseController
  def show
    render json: {}
  end

  def update
    render json: {}
  end

  def destroy
    head :no_content
  end
end
