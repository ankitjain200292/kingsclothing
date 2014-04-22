class CommentsController < ApplicationController
  
   #function for creating the instance of the comment class for the form
  def new
    @comment = Comment.new()
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.valid?
    
      @comment.save
      redirect_to home_path
     
    else
      flash[:error] = "*Please fill all the fields"
      redirect_to :action => "new"
    end
  end

  private
  def user_params
    params.require(:comment).permit(:name, :email, :phone, :comment)
  end
end
