Aws.config.update(
  region: 'ap-northeast-1' ,
  credentials: Aws::Credentials.new(Rails.application.credentials.aws.dig(:access_key_id), Rails.application.credentials.aws.dig(:secret_access_key))
)

s3_resource = Aws::S3::Resource.new
S3_BUCKET = s3_resource.bucket('terraform-20210903005815201900000001')