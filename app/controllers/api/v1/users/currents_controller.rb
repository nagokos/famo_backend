class Api::V1::Users::CurrentsController < ApplicationController
  def show
    render json: current_user
  end

  def update; end
end
