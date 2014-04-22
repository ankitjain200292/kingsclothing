class Admin::UsersController< ApplicationController
  
  #function for creating the instance of the user class for the form
  #authorize! function of cancan extension for checking authorization
  def new
    authorize! :create, @user
    @user = User.new
  end

  #function for creating the new user if user have permission
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      redirect_to admin_stories_path
    else
      render 'new'
    end
  end

  private
 #function for checking the user is login or not
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation,:role)
  end
end
