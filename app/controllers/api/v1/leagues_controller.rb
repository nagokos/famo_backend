class Api::V1::LeaguesController < ApplicationController
  def index
    leagues = League.preload(categories: [:groups])
    render json: leagues, each_serializer: LeagueSerializer, include: '**'
  end
end
