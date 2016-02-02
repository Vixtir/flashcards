CarrierWave.configure do |config|
 config.fog_credentials = {
    provider:              'AWS',         # required
    aws_access_key_id:     ENV["aws_key"],# required
    aws_secret_access_key: ENV["aws_secret"],  # required
    region:                ENV["aws_region"], # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = ENV["aws_dir"]
end
