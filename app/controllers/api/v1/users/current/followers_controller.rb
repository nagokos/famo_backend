class Api::V1::Users::Current::FollowersController < Api::V1::BaseController
  def index
    followers = current_user.followers.cache_profile
    render json: followers, each_serializer: RelationUserSerializer
  end
end
