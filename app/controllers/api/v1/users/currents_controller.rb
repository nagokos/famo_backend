class Api::V1::Users::CurrentsController < Api::V1::BaseController
  before_action :require_login, only: %i[update]

  def show
    render json: current_user
  end

  def update; end
end
