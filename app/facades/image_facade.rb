class ImageFacade
  def self.get_image(location)
    images = ImageService.get_images(location)
    Image.new(images[:results].first, location[:location])
  end
end
