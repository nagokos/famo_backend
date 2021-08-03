class Api::V1::Users::FollowersController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    followers = user.followers.cache_profile
    render json: followers, each_serializer: RelationUserSerializer
  end
end
