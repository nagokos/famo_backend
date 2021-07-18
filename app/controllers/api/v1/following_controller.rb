class Api::V1::FollowingController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    following = user.following
    render json: following, each_serializer: RelationUserSerializer
  end
end
