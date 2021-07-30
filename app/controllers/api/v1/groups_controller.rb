class Api::V1::GroupsController < Api::V1::BaseController
  def index; end

  def show
    users = League.find(params[:league_id]).categories.find(params[:category_id]).groups.find(params[:id])
    render json: users
  end
end
