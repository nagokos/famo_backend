class Api::V1::TopPlayersController < Api::V1::BaseController
  def index
    users = User.joins(:profile).cache_profile.top_rate.rate_desc.sample(20)
    render json: users, root: 'users'
  end
end
