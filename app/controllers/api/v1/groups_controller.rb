class Api::V1::GroupsController < ApplicationController
  def index
    groups = Group.all
    render json: groups, each_serializer: GroupSerializer
  end
end
