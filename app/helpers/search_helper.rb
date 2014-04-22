module SearchHelper
  
  #helper function for searching the thing like vedio,news,photos etc
  def searchitems(search,model,searchby)
    if search  
      model.paginate( :conditions => [searchby +' LIKE ?', "%#{search}%"],:page => params[:page], :per_page => 10)
    else  
      model.paginate(:page => params[:page], :per_page => 10) 
    end  
  end
end
