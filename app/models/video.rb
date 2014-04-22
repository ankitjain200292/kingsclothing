class Video < ActiveRecord::Base
  belongs_to :user
   validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  
  # function for checking the upload fields and then call video and thumbnails in the backend
  def self.upload(upload)
    if !upload['datafile'].nil?
      uploadvideo(upload)
    end
    if !upload['thumbnail'].nil?
    uploadthumb(upload)
    end
  end
  
  # function for uploading the video into the backend
  def self.uploadvideo(upload)
    name =  upload['datafile'].original_filename
    fileext = File::extname(name).downcase
    if fileext==".mp4" 
        videodirectory = "app/assets/images/video"
        # create the file path
        path = File.join(videodirectory, name)
        # write the file
        File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      else
        return false
      end
    
  end
  
  # function for uploading the thumb into the backend
  def self.uploadthumb(upload)
    thumbname = upload['thumbnail'].original_filename
    thumbfileext = File::extname(thumbname).downcase
      if thumbfileext==".png" or thumbfileext==".gif" or thumbfileext==".jpg" or thumbfileext==".jpeg"
        thumbdirectory = "app/assets/images/thumb"
        # create the file path
        thumbpath = File.join(thumbdirectory, thumbname)
        # write the file
        File.open(thumbpath, "wb") { |f| f.write(upload['thumbnail'].read) }
      else
        return false
      end
    end
end
