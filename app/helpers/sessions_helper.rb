module SessionsHelper
  
  #function for setting the user id in the session means user login
  def sign_in(user)
    session[:user_id] = user.id
  end

  #function for getting the current user from the session id
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # function for checking the user is signed in or not
  def signed_in?
    !current_user.nil?
  end

  # function for sigout of user
  def sign_out
    session[:user_id] = nil
  end
end
