class Api::V1::TeamsController < ApplicationController
  def index
    teams = Team.all
    render json: teams, each_serializer: TeamSerializer
  end

  def create
    team = Team.new(team_params)
    if team.save
      head :created
    else
      render json: { errors: team.errors }, status: :unprocessable_entity
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :kind, :prefecture_id)
  end
end
