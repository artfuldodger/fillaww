class ImagesController < ApplicationController
  def show
    image = Image.all.sample
    send_file image.file.path, type: image.file_content_type, disposition: :inline
  end
end
