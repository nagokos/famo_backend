class Api::V1::Users::Current::FollowingController < Api::V1::BaseController
  def index
    following = current_user.following.cache_profile
    @pagy, following = pagy(following)
    render json: following, each_serializer: RelationUserSerializer
  end
end
