class Api::V1::Categories::UsersController < Api::V1::BaseController
  def index
    players = User.joins(profile: { group: :category }).merge(Category.where(id: params[:category_id]))
    render json: players
  end
end
