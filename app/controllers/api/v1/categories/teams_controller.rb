class Api::V1::Categories::TeamsController < Api::V1::BaseController
  def index
    teams = Team.joins(profiles: { group: :category }).merge(Category.where(id: params[:category_id]))
    render json: teams
  end
end
