class Room < ActiveRecord::Base
  include FieldSanitizer
  
  attr_accessible :description, :location, :name
  
  before_validation { |room| room.nameize :name, :location }
  before_validation { |room| room.description = room.description.strip.capitalize }
end
