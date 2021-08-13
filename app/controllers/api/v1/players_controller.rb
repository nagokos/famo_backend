class Api::V1::PlayersController < Api::V1::BaseController
  def index
    search_users_form = SearchUsersForm.new(search_params)
    users = search_users_form.search
    begin
      @pagy, users = pagy(users)
    rescue Pagy::OverflowError => e
      return head :not_found
    end
    render json: users
  end

  private

  def search_params
    params[:q]&.permit(:league_id, :category_id, :group_id, :position, :team_id, :rating)
  end
end
