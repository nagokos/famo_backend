class Api::V1::ProfilesController < ApplicationController
  before_action :required_login, only: %i[create show]

  def create
    profile = current_user.build_profile(profile_params)
    if profile.save
      render json: profile, status: :created
    else
      render json: { errors: profile.errors }, status: :unprocessable_entity
    end
  end

  def update; end

  def profile_params
    params.require(:profile).permit(:position, :official_number, :practice_number, :group_id, :team_id)
  end
end
