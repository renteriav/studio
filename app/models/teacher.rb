# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  first      :string(255)
#  last       :string(255)
#  email      :string(255)
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
  
  attr_accessible :address_id, :email, :first, :last, :telephones_attributes, :addresses_attributes, :instrument_ids
  
  before_validation { |teacher| teacher.nameize :first, :last }
  before_validation { |teacher| teacher.email = teacher.email.strip.downcase }
  
	validates :first, presence: true, length: { maximum: 30 }
	validates :last, presence: true, length: { maximum: 30 }
	validates :email, presence: true, length: { maximum: 80 }
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
