class Api::V1::CategoriesController < Api::V1::BaseController
  def show
    category = League.find(params[:league_id]).categories.find(params[:id])
    render json: category
  end
end
