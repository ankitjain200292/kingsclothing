class Admin::VideosController < ApplicationController
  
  #function which run before any other function runs
  before_filter :login
  
  #function of cancan plugin for checking the authorization process
  load_and_authorize_resource except: [:create]
  
  #function for showing the list of all videos
  #authorize! function of cancan extension for checking authorization
  def index
    authorize! :read, @videos
    @videos = searchitems(params[:search],Video,'video_name')
    @video = @videos.first
  end

  #function for creating the instance of the video class for the form
  #authorize! function of cancan extension for checking authorization
  def new
    authorize! :create, @videos
    @videos = Video.new
  end

  #function for uploading the video and thumbnails from the backend
  def create
    
    if params[:upload].nil?
      flash[:error] = "Please select a file"
      redirect_to  new_admin_video_path
    else
      if params[:upload][:datafile].nil? or params[:upload][:thumbnail].nil? or params[:video][:title]=="" or params[:video][:description]==""
        flash[:error] = "Please Fill all the fields"
        redirect_to  new_admin_video_path
      else
        post = Video.uploadvideo(params[:upload])
        if post
          post = Video.uploadthumb(params[:upload])
          if post
            
            # for associating the video with the user
            @videos  = current_user.videos.new(user_params)
            @videos.update_attributes(:video_name => params[:upload][:datafile].original_filename,:thumb_name => params[:upload][:thumbnail].original_filename ) 
            @videos.save
            redirect_to admin_videos_path
          end
        else
          flash[:error] = "Please select a valid file"
          redirect_to new_admin_video_path
        end
      end
    end
  end
  
  #function for getting the requested video by the user
  def show
    @videos = Video.find_by(id: params[:id])
  end

  #function for creating the object of video to be edited by the user
  #authorize! function of cancan extension for checking authorization
  def edit
    authorize! :update, @videos
    @videos = Video.find_by(id: params[:id])
  end

  #function for updating the requested video edited by the user 
  def update
    @videos = Video.find_by(id: params[:id])
    if params[:video][:title]=="" or params[:video][:description]==""
      flash[:error] = "Please Fill all the fields"
      redirect_to  edit_admin_video_path(@videos)  
    else
      if params[:upload].nil?
        @videos.update_attributes(:title =>params[:video][:title],:description =>params[:video][:description])   
      elsif params[:upload][:datafile].nil?
        post = Video.uploadthumb(params[:upload])
        if post
          @videos.update_attributes(:title =>params[:video][:title],:description =>params[:video][:description],:thumb_name => params[:upload][:thumbnail].original_filename )  
        end
      elsif params[:upload][:thumbnail].nil? 
        post = Video.uploadvideo(params[:upload])
        if post
          @videos.update_attributes(:title =>params[:video][:title],:description =>params[:video][:description],:video_name => params[:upload][:datafile].original_filename) 
        end
      else  
        post = Video.upload(params[:upload])
        if post
        end
        @videos.update_attributes(:title =>params[:video][:title],:description =>params[:video][:description],:video_name => params[:upload][:datafile].original_filename,:thumb_name => params[:upload][:thumbnail].original_filename ) 
      end
      redirect_to admin_videos_path
    end
  end
  #function for deleting the single video requested by user
  def destroy
    authorize! :destroy, @videos
    Video.find(params[:id]).destroy
    redirect_to admin_videos_path
           
  end

  #function for deleting the multiple video requested by user called from ajax by the index view
  #params[:records] array of id have to be deleted
  def deletevideos
    @video = params[:records]
    @video.each do |id|
      Video.find_by_id(id).destroy
    end
    redirect_to admin_videos_path
  end


  private
  #funciton for checking if user is signed in or not
  def login
    if not signed_in?
      flash[:error]='Please sign in First'
      redirect_to new_admin_session_path
    end
  end
  
  # function for defining the strong parameter introduced in rails 4.0
  def user_params
    params.require(:upload).permit(:datafile,:thumbnail)
    params.require(:video).permit(:title,:description,:user_id)
  end
end
