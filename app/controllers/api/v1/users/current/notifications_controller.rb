class Api::V1::Users::Current::NotificationsController < Api::V1::BaseController
  before_action :check_login

  def index
    notifications = current_user.passive_notifications.includes([:visitor]).order(created_at: :desc)
    @pagy, notifications = pagy(notifications, items: 5)
    render json: notifications
  end

  def update
    if params[:id] != '0'
      notification = current_user.passive_notifications.find(params[:id])
      notification.checked = true
      notification.save
      render json: notification
    else
      notifications = current_user.passive_notifications.where(checked: false)
      notifications.update_all(checked: true)
      notifications = current_user.passive_notifications.includes([:visitor]).order(created_at: :desc)
      @pagy, notifications = pagy(notifications, items: 5)
      render json: notifications
    end
  end

  def check
    boolean = current_user.passive_notifications.exists?(checked: false)
    render json: boolean
  end
end
