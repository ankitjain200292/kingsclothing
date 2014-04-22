class Comment < ActiveRecord::Base

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :phone, :comment

  validates :name, :email, :phone, :comment, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  
  def initialize(attributes = {})
   
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
end
