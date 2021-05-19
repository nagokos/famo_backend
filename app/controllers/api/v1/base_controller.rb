class Api::V1::BaseController < ApplicationController
  before_action :check_xhr_header, only: %i[create update]

  private

  def check_xhr_header
    return if request.xhr?

    render json: { error: 'forbidden' }, status: :forbidden
  end
end
