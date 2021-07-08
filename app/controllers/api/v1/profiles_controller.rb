class Api::V1::ProfilesController < ApplicationController
  before_action :required_login, only: %i[create show update destroy]

  def create
    profile = current_user.build_profile(profile_params)
    if profile.save
      current_user.player!
      render json: profile, include: '**', status: :created
    else
      render json: { errors: profile.errors }, status: :unprocessable_entity
    end
  end

  def show
    profile = current_user.profile
    render json: profile, include: '**'
  end

  def update
    profile = current_user.profile
    profile.assign_attributes(profile_params)
    if profile.save
      render json: profile, include: '**', status: :ok
    else
      render json: { errors: profile.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.profile.destroy!
    current_user.reviewer!
  end

  private

  def profile_params
    params.require(:profile).permit(:position, :official_number, :practice_number, :career, :group_id, :team_id)
  end
end
