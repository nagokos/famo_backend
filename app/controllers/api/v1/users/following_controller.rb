class Api::V1::Users::FollowingController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    following = user.following.includes(profile: [team: :prefecture, group: { category: :league }])
    render json: following, each_serializer: RelationUserSerializer
  end
end
