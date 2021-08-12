class Api::V1::Leagues::TeamsController < Api::V1::BaseController
  def index
    teams = Team.joins(profiles: { group: { category: :league } }).merge(League.where(id: params[:league_id]))
    render json: teams
  end
end
