# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  location    :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Room < ActiveRecord::Base
  include FieldSanitizer
  
  attr_accessible :description, :location, :name
  
  before_validation { |room| room.nameize :name, :location }
  before_validation { |room| room.description = room.description.strip.capitalize }
  
  def room_description
    loc = location.empty? ? "" : "(#{location})"
    "#{name} #{loc}"
  end
end
