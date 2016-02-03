require "rails_helper"
require "carrierwave/test/matchers"

describe PictureUploader do
  include CarrierWave::Test::Matchers

  before(:all) do
    PictureUploader.enable_processing = true
  end

  before(:each) do
    @card = create(:card)
    @uploader = PictureUploader.new(@card, :picture)
    @uploader.store!(File.open("#{Rails.root}/spec/images/123.jpg"))
  end

  after(:all) do
    PictureUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the default version' do
    it 'scales down an image to be no larger than 360 by 360 pixels' do
      @uploader.should be_no_larger_than(360, 360)
    end
  end
end
