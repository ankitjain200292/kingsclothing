class ContactusController < ApplicationController
  
  #function for creating the instance of the contactus class for the form
  def new
    @contactus = Contactu.new()
  end
  
  #function for saving the comments by user in the database
  def create
    @contactus = Contactu.new(user_params)
    if @contactus.valid?
    
      @contactus.save
      flash[:sucess] = "Thankyou for your suggestion we will come back to you soon"
      redirect_to home_path
     
    else
      flash[:error] = "*Please fill all the fields"
      redirect_to :action => "new"
    end
  end
  
  #function for checking the allowed params by the form post
  private
  def user_params
    params.require(:contactu).permit(:name, :email, :phone, :comment)
  end
end
