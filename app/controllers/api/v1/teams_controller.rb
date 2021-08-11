class Api::V1::TeamsController < Api::V1::BaseController
  before_action :required_login, only: %i[create]
  before_action :check_activation, only: %i[create]

  def index
    teams = Team.all
    render json: teams
  end

  def create
    team = Team.new(team_params)
    if team.save
      render json: team, status: :created
    else
      render json: { errors: team.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :prefecture_id)
  end
end
