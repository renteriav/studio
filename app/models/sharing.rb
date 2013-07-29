# == Schema Information
#
# Table name: sharings
#
#  id         :integer          not null, primary key
#  date       :date
#  start_time :time
#  end_time   :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sharing < ActiveRecord::Base
  
  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  
  attr_accessor :status
  attr_accessor :comp_id
  attr_accessor :student_id
  attr_accessor :teacher_id
  attr_accessor :room_id
  
  accepts_nested_attributes_for :teachers
  
  attr_accessible :end_time, :date, :start_time, :teacher_ids
  
  #:comp_id, :status
end
