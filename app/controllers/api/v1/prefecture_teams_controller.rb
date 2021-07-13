class Api::V1::PrefectureTeamsController < Api::V1::BaseController
  def index
    prefectures = Prefecture.preload(:teams)
    render json: prefectures, each_serializer: PrefectureSerializer
  end
end
