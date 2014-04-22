  class Admin::PhotosController < ApplicationController
  #function for checking the user is login or not 
  before_filter :login
  
  #function for showing the list of all photos
  #authorize! function of cancan extension for checking authorization
 # def index
    #authorize! :read, @photos
    #@photos = searchitems(params[:search],Photo,'image_name')
    #@photo = @photos.first

def index
    if params[:query].present?
      @photos = Photo.search params[:query], page: params[:page], partial: true,misspellings: {distance: 2}
      @photo = @photos.first
    else
      @photos = Photo.order_by_rand.limit(3).all
      #@photos = Photo.all.page params[:page]
      @photo = @photos.first
    end
  end
  #end

  #function for creating the instance of the photo class for the form
  #authorize! function of cancan extension for checking authorization
  def new
    if signed_in?
      authorize! :create, @photos
      @photos = Photo.new
    else
      flash[:error]='Please sign in First'
      redirect_to new_admin_session_path
    end
  end

  #function for uploading the photo from the backend
  def create
    if params[:upload].nil?
      flash[:error] = "Please select a file"
      redirect_to  new_admin_photo_path
    else
      post = Photo.uploadimage(params[:upload])
      if post
        @photo  = Photo.new(:image_name =>params[:upload][:datafile].original_filename)
        @photo.save
        redirect_to admin_photos_path
      else
        flash[:error] = "Please select a valid file"
        redirect_to new_admin_photo_path
      end
    end
  end
  
  #function for getting the requested photo by the user
  def show
    @photos = Photo.find_by(id: params[:id])
  end

  #function for creating the object of photo to be edited by the user
  #authorize! function of cancan extension for checking authorization
  def edit
    authorize! :update, @photos
    @photos = Photo.find_by(id: params[:id])
  end

  #function for updating the requested photo edited by the user 
  def update
    @photos = Photo.find_by(id: params[:id])
    if params[:upload].nil?
      flash[:error] = "Please select a file"
      redirect_to  edit_admin_photo_path(@photos)
    else
      post = Photo.uploadimage(params[:upload])
      if post
        @photos.update_attributes(:image_name =>params[:upload][:datafile].original_filename)
        redirect_to admin_photos_path
      else
        redirect_to new_admin_photo_path
      end
    end
  end
 
  #function for deleting the single photo requested by user
  def destroy
    authorize! :destroy, @photos
    Photo.find(params[:id]).destroy
    redirect_to admin_photos_path       
  end

  #function for deleting the multiple photo requested by user called from ajax by the index view
  #params[:records] array of id have to be deleted
  def deletephotos
    @photos = params[:records]
    @photos= @photos.uniq
    @photos.each do |id|
      Photo.find_by_id(id).destroy
    end
    redirect_to admin_photos_path
  end

  private
 #function for checking the user is login or not
  def login
    if not signed_in?
      flash[:error]='Please sign in First'
      redirect_to new_admin_session_path
    end
  end
end
