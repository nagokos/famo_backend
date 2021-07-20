class Api::V1::Users::Current::FollowingController < ApplicationController
  def index
    following = current_user.following
    render json: following, each_serializer: RelationUserSerializer
  end
end