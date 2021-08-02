class Api::V1::Categories::UsersController < Api::V1::BaseController
  def index
    users = User.joins(profile: { group: :category }).merge(Category.where(id: params[:category_id]))
    render json: users
  end
end
