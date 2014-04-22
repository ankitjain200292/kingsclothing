class PhotosController < ApplicationController
  
  #function for showing the list of all photos
  #authorize! function of cancan extension for checking authorization
  def index
    @photos = Photo.paginate(:page => params[:page], :per_page => 8)
  end 
end
