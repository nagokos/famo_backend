class Api::V1::Groups::UsersController < Api::V1::BaseController
  def index
    users = User.joins(profile: :group).merge(Group.where(id: params[:group_id]))
    render json: users
  end

  def show
    user = League.find(params[:league_id]).categories.find(params[:category_id]).groups.find(params[:group_id]).profiles.find_by(user_id: params[:id]).user
    render json: user
  end
end
