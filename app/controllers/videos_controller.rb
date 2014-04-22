class VideosController < ApplicationController

   #function for showing the list of all videos
  def index
    @video = Video.paginate(:page => params[:page], :per_page => 8)
  end 
  
   #function for showing the video clicked by the user
  def show
    @currentvideo = Video.find_by(id: params[:id])
    @video = Video.paginate(:page => params[:page], :per_page => 8)
    @postedby = @currentvideo.user.name
  end
end
