Aws.config.update(
  region: 'ap-northeast-1',
  credentials: Aws::Credentials.new(Rails.application.credentials.aws[:access_key_id], Rails.application.credentials.aws[:secret_access_key])
)

s3_resource = Aws::S3::Resource.new
S3_BUCKET = s3_resource.bucket(Rails.application.credentials.aws[:bucket])

Aws::Rails.add_action_mailer_delivery_method(:ses) if Rails.env == 'production'
