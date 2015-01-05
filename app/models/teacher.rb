# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  first      :string(255)
#  last       :string(255)
#  email      :string(255)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ActiveRecord::Base
  include FieldSanitizer
  
	has_many :telephones, :as => :phoneable, :dependent => :destroy
	accepts_nested_attributes_for :telephones, :allow_destroy => true, :reject_if => proc { |attributes| attributes['number'].blank? }
  
  has_many :addresses, :as => :addressable
  accepts_nested_attributes_for :addresses
  
  has_and_belongs_to_many :instruments
  
  has_many :lessons
  has_many :extras

  has_one :user, as: :loginable
  accepts_nested_attributes_for :user
  
  attr_accessible :address_id, :email, :status, :first, :last, :telephones_attributes, :addresses_attributes, :instrument_ids, :users_attributes
  
  before_validation { |teacher| teacher.nameize :first, :last }
  before_validation { |teacher| teacher.email = teacher.email.strip.downcase }
  
  validates_associated :telephones, presence: { message: "Please enter a valid number." }
  validates_presence_of :telephones, message: "Enter a valid number"
  
	validates :first, presence: {message: "Enter first name"}, length: { maximum: 30 } 
	validates :last, presence: {message: "Enter last name"}, length: { maximum: 30 }
	validates :email, presence: {message: "Enter a valid email"}, length: { maximum: 80 }
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: "Enter a valid email" }
end
