class Api::V1::Users::Current::ProfilesController < Api::V1::BaseController
  before_action :required_login, only: %i[create update destroy]
  before_action :check_activation, only: %i[create update destroy]

  def create
    profile = current_user.build_profile(profile_params)
    if profile.save
      current_user.player!
      render json: profile, status: :created
    else
      render json: { errors: profile.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
    end
  end

  def update
    profile = current_user.profile
    profile.assign_attributes(profile_params)
    if profile.save
      render json: profile, status: :ok
    else
      render json: { errors: profile.errors, message: 'フォームに不備があります' }, status: :unprocessable_entity
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