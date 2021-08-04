class Api::V1::Groups::TeamsController < ApplicationController
  def index
    teams = Team.joins(profiles: :group).merge(Group.where(id: params[:group_id]))
    render json: teams
  end
end
