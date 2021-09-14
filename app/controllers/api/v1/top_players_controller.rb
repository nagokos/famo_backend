class Api::V1::TopPlayersController < Api::V1::BaseController
  def index
    users = User.cache_profile.joins(:profile).rate_desc.sample(20)
    render json: users, root: 'users'
  end
end
