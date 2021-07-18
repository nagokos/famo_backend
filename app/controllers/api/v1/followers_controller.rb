class Api::V1::FollowersController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    followers = user.followers
    render json: followers, each_serializer: RelationUserSerializer
  end
end
