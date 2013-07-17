# == Schema Information
#
# Table name: attendances
#
#  id              :integer          not null, primary key
#  attendable_id   :integer
#  attendable_type :string(255)
#  teacher_id      :integer
#  date            :date
#  status          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Attendance < ActiveRecord::Base
  belongs_to :attendable, :polymorphic => true
  
  attr_accessible :attendable_id, :attendable_type, :date, :status
  
end
