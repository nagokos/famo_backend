class Api::V1::GroupsController < Api::V1::BaseController
  def index
    categories = Group.includes(:category).where(category_id: params[:category_id])
    render json: categories
  end

  def show
    group = Group.find(params[:id])
    render json: group, nested: true
  end
end
