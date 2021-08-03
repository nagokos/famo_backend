class Api::V1::Users::Current::FollowingController < Api::V1::BaseController
  def index
    following = current_user.following.includes(profile: [team: :prefecture, group: { category: :league }])
    render json: following, each_serializer: RelationUserSerializer
  end
end
