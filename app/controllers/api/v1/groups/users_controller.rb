class Api::V1::Groups::UsersController < Api::V1::BaseController
  def index
    users = User.cache_profile.joins(profile: :group).merge(Group.where(id: params[:group_id]))
    render json: users
  end
end
