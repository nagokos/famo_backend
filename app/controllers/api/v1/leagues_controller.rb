class Api::V1::LeaguesController < ApplicationController
  def index
    leagues = League.all
    render json: leagues, each_serializer: LeagueSerializer
  end
end
