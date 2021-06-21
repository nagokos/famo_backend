class Api::V1::PrefectureTeamsController < ApplicationController
  def index
    prefectures = Prefecture.preload(:teams)
    render json: prefectures, each_serializer: PrefectureSerializer
  end
end
