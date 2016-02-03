CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS', 
    aws_access_key_id:     ENV["aws_key"], 
    aws_secret_access_key: ENV["aws_secret"], 
    region:                ENV["aws_region"]
  }
  config.fog_directory  = ENV["aws_dir"]
end
