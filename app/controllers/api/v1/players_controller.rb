class Api::V1::PlayersController < ApplicationController
  def index
    search_users_form = SearchUsersForm.new(search_params)
    users = search_users_form.search
    render json: users
  end

  private

  def search_params
    params[:q]&.permit(:league_id, :category_id, :group_id, :position, :team_id)
  end
end
