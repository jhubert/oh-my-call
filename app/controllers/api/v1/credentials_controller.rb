class Api::V1::CredentialsController < Api::V1::BaseController
  def me
    render json: { id: 1, sign_in_count: 0 }
  end
end
