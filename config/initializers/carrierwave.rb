CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS', 
    aws_access_key_id: ENV["S3_ACCESS_KEY_ID"], 
    aws_secret_access_key: ENV["S3_SECRET_ACCESS_KEY"], 
    region: ENV["S3_REFION"]
  }
  config.fog_directory  = ENV["AWS_BUCKET"]
end
