module ErrorHandle
  extend ActiveSupport::Concern

  included do
    class Forbidden < ActionController::ActionControllerError; end
    rescue_from Exception, with: :rescue500
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    rescue_from Forbidden, with: :rescue403
    rescue_from Pagy::OverflowError, with: :pagy_overflow
  end

  def check_xhr_header
    return if request.xhr?

    render json: { messge: 'アクセス権がありません' }, status: :forbidden
  end

  def check_activation
    return if current_user.activation_token.nil?

    render json: { message: 'アカウントを認証してください' }, status: :forbidden
  end

  private

  def rescue500(e)
    @exception = e
    return head :internal_server_error
  end

  def rescue403(e)
    @exception = e
    return head :forbidden
  end

  def rescue404(e)
    @exception = e
    return head :not_found
  end

  def pagy_overflow(e)
    @exception = e
    return head :not_found
  end
end