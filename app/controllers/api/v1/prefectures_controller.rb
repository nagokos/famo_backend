class Api::V1::PrefecturesController < ApplicationController
  def index
    prefectures = Prefecture.preload(:teams)
    render json: prefectures, each_serializer: PrefectureSerializer
  end
end
