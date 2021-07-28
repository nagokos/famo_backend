class Api::V1::GroupsController < Api::V1::BaseController
  def show
    group = Group.find(params[:id])
    render json: group
  end
end
