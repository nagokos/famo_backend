class Api::V1::Users::Current::ProfilesController < Api::V1::BaseController
  before_action :required_login, only: %i[create update destroy]
  before_action :check_activation, only: %i[create update destroy]
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

  def check_age
    if (!current_user.birth_date.present?)
      return render json: { message: '生年月日を登録してください' }, status: :bad_request
    end
    today = if (Date.today.strftime('%m%d').to_i < '0402'.to_i)
              Date.today.ago(1.years)
            else
              Date.today
            end
    first = today.ago(15.years).strftime('%Y0401')
    third = today.ago(18.years).strftime('%Y0402')
    birth = current_user.birth_date.strftime('%Y%m%d')
    unless (birth.to_i >= third.to_i && birth.to_i <= first.to_i)
      return render json: { message: '高校生のみ登録可能です' }, status: :bad_request
    end
  end
end
