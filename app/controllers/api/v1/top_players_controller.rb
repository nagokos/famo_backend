class Api::V1::TopPlayersController < Api::V1::BaseController
  def index
    users = User.cache_profile.joins(:profile).order(rate: :desc).limit(200).shuffle[0..19]
    render json: users
  end
end
