class Api::V1::Users::Current::ProfilesController < Api::V1::BaseController
  before_action :required_login, only: %i[create update destroy]
  before_action :check_activation, only: %i[create update destroy]
  before_action :check_birthday, only: %i[create update]
  before_action :check_age, only: %i[create update]

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

  def check_birthday
    return render json: { message: '生年月日を登録してください' }, status: :bad_request unless current_user.birth_date.present?
  end

  def check_age
    today = if Time.current.strftime('%m%d').to_i < '0402'.to_i
              Time.current.ago(1.years)
            else
              Time.current
            end
    first = today.ago(15.years).strftime('%Y0401')
    third = today.ago(18.years).strftime('%Y0402')
    birth = current_user.birth_date.strftime('%Y%m%d')
    return render json: { message: '高校生のみ登録可能です' }, status: :bad_request if birth.to_i < third.to_i || birth.to_i > first.to_i
  end
end
