class Admin::StoriesController < ApplicationController
  before_filter :login

  #function for checking of user signin and show all list of stories
  def index
    
    if params[:query].present?
      @stories = Story.search params[:query], page: params[:page], partial: true,misspellings: {distance: 2}
      @storie = Story.first
    else
      @stories = Story.all.page params[:page]
      @storie = Story.first
    end
    
    
#    if signed_in?
#      authorize! :read, @stories
#      @stories = searchitems(params[:search],Story,'title')
#      @storie = @stories.first
#    else
#      flash[:error]='Please sign in First'
#      redirect_to new_admin_session_path
#    end
  end

  #function for adding new story
  def new
    authorize! :create, @stories
    @stories = Story.new
  end
  
  #function for creating new stories
  def create
    @stories = current_user.stories.new(user_params)
    if @stories.valid?
    
      @stories.save
      redirect_to  admin_stories_path
     
    else
      flash[:error] = "*Please fill all the fields"
      redirect_to :action => "new"
    end
  end
  
  #function for showing the selected story
  def show
    @Stories = Story.find_by(id: params[:id])
    redirect_to @Stories
  end

  #function for editing the selected story
  def edit
    authorize! :update, @stories
    @Stories = Story.find_by(id: params[:id])
  end
  
  #function for updating the selected story
  def update
    @Stories = Story.find(params[:id])
    if @Stories.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to  admin_stories_path
    else
      render 'edit'
    end
  end

  #function for distroying the selected story
  def destroy
    authorize! :destroy, @stories
    Story.find(params[:id]).destroy
    redirect_to  admin_stories_path
  end
  
  #function for deleting more then one news selected by the user
  #params[:records] id of the stories to be deleted by the user
  def deletenews
    @story = params[:records]
    @story.each do |id|
      Story.find_by_id(id).destroy
    end
    redirect_to admin_photos_path
  end

  private
  #function for defining the strong parameter
  def user_params
    params.require(:story).permit(:title, :news)
  end
  #funciton for checking if user is signed in or not
  def login
    if not signed_in?
      flash[:error]='Please sign in First'
      redirect_to new_admin_session_path
    end
  end
end
