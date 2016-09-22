class ImageUploader
  attr_reader :outfit, :base64_string

  def initialize(outfit:, base64_string:)
    @outfit = outfit
    @base64_string = base64_string
  end

  # def self.upload_from_string(base64_string:, filename:)
  #   new(source_type: 'base64_encoded_string',
  #       source_data: base64_string,
  #       filename: filename).perform
  # end

  def self.perform (outfit: , base64_string:)
    new(outfit: outfit, base64_string: base64_string).perform
  end

  def perform
    download_image
    file = File.open('tmp/image.png', 'rb')
    binding.pry
    outfit.photo = file
    outfit.save
    # upload_to_aws
  end

  private

  def download_image
      download_image_from_base64_string
  end

  def download_image_from_base64_string
    File.open('tmp/image.png', 'wb') do |file|
      file.write(Base64.decode64(base64_string))
    end
  end

end
