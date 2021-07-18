class Api::V1::Users::Current::FollowersController < ApplicationController
  def index
    followers = current_user.followers
    render json: followers, each_serializer: RelationUserSerializer
  end
end
