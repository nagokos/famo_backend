class Api::V1::TeamsController < Api::V1::BaseController
  before_action :required_login, only: %i[create]

  def create
    team = Team.new(team_params)
    if team.save
      render json: team, status: :created
    else
      render json: { errors: team.errors }, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :kind, :prefecture_id)
  end
end
