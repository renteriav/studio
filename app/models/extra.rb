# == Schema Information
#
# Table name: extras
#
#  id            :integer          not null, primary key
#  student_id    :integer
#  teacher_id    :integer
#  instrument_id :integer
#  room_id       :integer
#  start_time    :time
#  end_time      :time
#  category      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Extra < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :teacher
  belongs_to :instrument
  has_many :attendances, :as => :attendable
  
  accepts_nested_attributes_for :attendances
  
  attr_accessor :status
  
  attr_accessible :end_time, :date, :instrument_id, :room_id, :start_time, :student_id, :teacher_id, :category, :attendances_attributes
    
end
