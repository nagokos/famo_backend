class Api::V1::PrefecturesTeamsController < ApplicationController
  def index
    prefectures = Prefecture.preload(:teams)
    render json: prefectures, each_serializer: PrefectureSerializer
  end
end
