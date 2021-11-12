class Api::V1::LeaguesController < Api::V1::BaseController
  def index
    leagues = League.all
    render json: leagues, nested: false
  end

  def show
    league = League.find(params[:id])
    render json: league, nested: true
  end
end
