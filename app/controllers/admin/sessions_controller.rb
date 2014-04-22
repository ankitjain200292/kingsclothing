class Admin::SessionsController < ApplicationController
  #funciton for checking if user is signed in if not then render signin page
  def new
    if signed_in?
    else
      render 'new'
    end
  end
  
  #funciton for hendling the login request by the user
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      #call the function define in the helperclass for signup
      sign_in @user
      redirect_to admin_stories_path
    else
      flash[:error]='please check you username and password'
      render 'new'
    end
  end
  # function for calling the sign_out method in helper class on user logout
  def destroy
    sign_out
    redirect_to new_admin_session_path
  end
end
