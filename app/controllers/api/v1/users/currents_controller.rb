class Api::V1::Users::CurrentsController < Api::V1::BaseController
  def show
    render json: current_user
  end

  def update; end
end
