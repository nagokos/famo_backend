class Api::V1::HierarchyLeaguesController < Api::V1::BaseController
  def index
    leagues = League.preload(categories: [:groups])
    render json: leagues, each_serializer: LeagueSerializer, include: '**', nested: true
  end
end
