class Api::V1::PrefecturesController < ApplicationController
  def index
    prefectures = Prefecture.all
    render json: prefectures, each_serializer: PrefectureSerializer
  end
end
