require 'spec_helper'

describe Admin::PhotosController do
  
   before(:each) do
        @photos = Photo.reindex
    end
    
  
  describe "GET index" do
    
    describe "for photo search" do

        it "should implement elastic search" do
             @photos = Photo.search 'lorum'
        end

    end

    
end
end

  