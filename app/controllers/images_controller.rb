class ImagesController < ApplicationController
  def show
    image = Image.all.sample
    image = Magick::Image::read(image.file.path).first
    image.format = 'jpg'
    send_data image.to_blob, disposition: :inline, type: 'image/jpg'
  end
end
