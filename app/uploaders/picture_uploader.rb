# encoding: utf-8
class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

 # if Rails.env.test?
   # storage :file
 # else
  storage :fog
 # end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit:  [360, 360]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
