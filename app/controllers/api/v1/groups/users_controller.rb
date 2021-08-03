class Api::V1::Groups::UsersController < Api::V1::BaseController
  def index
    users = User.joins(profile: :group).merge(Group.where(id: params[:group_id]))
    render json: users
  end
end
