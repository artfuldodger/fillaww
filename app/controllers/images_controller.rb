class ImagesController < ApplicationController
  def show
    image = Image.all.sample
    image = Magick::Image::read(image.file.path).first
    image.format = 'jpg'
    if params[:width] && params[:height]
      image = image.resize_to_fill(params[:width].to_i, params[:height].to_i)
    end
    send_data image.to_blob, disposition: :inline, type: 'image/jpg'
  end
end
