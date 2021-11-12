class Api::V1::Users::Current::NotificationsController < Api::V1::BaseController
  before_action :check_login

  def index
    notifications = current_user.passive_notifications.includes([:visitor]).order(created_at: :desc)
    @pagy, notifications = pagy(notifications, items: 5)
    render json: notifications
  end

  def update
    notification = current_user.passive_notifications.find(params[:id])
    notification.update!(checked: true)
    render json: notification
  end

  def checked
    notifications = current_user.passive_notifications.includes([:visitor]).order(created_at: :desc)
    notifications.update_all(checked: true)
    @pagy, notifications = pagy(notifications, items: 5)
    render json: notifications
  end

  def check
    boolean = current_user.passive_notifications.exists?(checked: false)
    render json: boolean
  end
end
