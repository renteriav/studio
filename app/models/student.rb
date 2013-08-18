# == Schema Information
#
# Table name: students
#
#  id          :integer          not null, primary key
#  first       :string(255)
#  last        :string(255)
#  cell        :string(255)
#  email       :string(255)
#  birthdate   :date
#  grade       :integer
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Student < ActiveRecord::Base
 
  include FieldSanitizer
  
  belongs_to :customer
  
	has_many :telephones, :as => :phoneable, :dependent => :destroy
	accepts_nested_attributes_for :telephones, :allow_destroy => true, :reject_if => proc { |attributes| attributes['number'].blank? }
  
  has_many :lessons
  has_many :extras
  has_many :detailed_sharings
  
  attr_accessible :first, :last, :telephones_attributes, :email, :birthdate, :grade, :customer_id, :schoolyear
  
  before_validation { |student| student.nameize :first, :last }
  before_validation { |student| student.email = student.email.strip.downcase }
end
