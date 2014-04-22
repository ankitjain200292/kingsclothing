class StoriesController < ApplicationController
  
  #function for showing the list of all stories
  def index
    @stories = Story.all
    #@stories= Story.paginate(:page => params[:page], :per_page => 1)
  end
  
   #function for showing the news clicked by the user
  def show
    @stories = Story.find_by(id: params[:id])
    
  end

  def new
    
  end

  def create
    
  end

  def edit
    
  end

  def update
   
  end

  def destroy
    
  end
end
