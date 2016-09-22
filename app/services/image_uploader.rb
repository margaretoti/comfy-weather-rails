class ImageUploader
  attr_reader :outfit, :base64_string

  def initialize(outfit:, base64_string:)
    @outfit = outfit
    @base64_string = base64_string
  end

  def self.perform (outfit: , base64_string:)
    new(outfit: outfit, base64_string: base64_string).perform
  end

  def perform
    download_image
    file = File.open('tmp/image.jpg', 'rb')
    outfit.photo = file
    outfit.save
  end

  private

  def download_image
      download_image_from_base64_string
  end

  def download_image_from_base64_string
    File.open('tmp/image.jpg', 'wb') do |file|
      file.write(Base64.decode64(base64_string))
    end
  end

end
