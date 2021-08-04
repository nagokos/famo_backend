class Api::V1::CategoriesController < Api::V1::BaseController
  def index
    categories = Category.includes(%i[league groups]).where(league_id: params[:league_id])
    render json: categories
  end

  def show
    category = League.find(params[:league_id]).categories.find(params[:id])
    render json: category
  end
end
