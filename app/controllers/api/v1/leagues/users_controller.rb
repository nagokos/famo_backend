class Api::V1::Leagues::UsersController < Api::V1::BaseController
  def index
    users = User.joins(profile: { group: { category: :league } }).merge(League.where(id: params[:league_id]))
    render json: users
  end
end
