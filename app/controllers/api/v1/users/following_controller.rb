class Api::V1::Users::FollowingController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    following = user.following
    render json: following, each_serializer: RelationUserSerializer
  end
end
