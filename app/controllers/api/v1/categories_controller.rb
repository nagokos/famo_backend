class Api::V1::CategoriesController < Api::V1::BaseController
  def show
    category = Category.find(params[:id])
    render json: category
  end
end
