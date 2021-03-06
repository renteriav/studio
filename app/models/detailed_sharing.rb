# == Schema Information
#
# Table name: detailed_sharings
#
#  id         :integer          not null, primary key
#  student_id :integer
#  sharing_id :integer
#  attendance :boolean
#  memory     :boolean
#  practice   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DetailedSharing < ActiveRecord::Base
  
  belongs_to :student
  belongs_to :sharing
  has_many :detailed_sharings
  
  accepts_nested_attributes_for :detailed_sharings
  
  attr_accessible :student_id, :sharing_id, :attendance, :memory, :practice
end
