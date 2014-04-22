class Photo < ActiveRecord::Base
  searchkick
  # function for uploading the image to the image folderin assets folder
  def self.uploadimage(upload)
    name =  upload['datafile'].original_filename
    fileext = File::extname(name).downcase
    if fileext==".png" or fileext==".gif" or fileext==".jpg" or fileext==".jpeg"
      directory = "#{Rails.root}/app/assets/images/image"
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    else
      return false
    end
  end
end
