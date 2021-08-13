class Api::V1::BaseController < ApplicationController
  before_action :check_xhr_header, only: %i[create update destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  include Pagy::Backend

  private

  def check_xhr_header
    return if request.xhr?

    render json: { error: 'forbidden' }, status: :forbidden
  end

  def check_activation
    return if current_user.activation_token.nil?

    render json: { message: 'アカウントを認証してください' }, status: :forbidden
  end
end
