class Api::V1::PlayersController < Api::V1::BaseController
  def index
    search_users_form = SearchUsersForm.new(search_params)
    users = search_users_form.search
    @pagy, users = pagy(users)
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  private

  def search_params
    params[:q]&.permit(:league_id, :category_id, :group_id, :position, :team_id, :rating)
  end
end
