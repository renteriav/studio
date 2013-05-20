# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  first      :string(255)
#  last       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ActiveRecord::Base
  include FieldSanitizer
	has_many :telephones, :as => :phoneable, :dependent => :destroy
	accepts_nested_attributes_for :telephones, :allow_destroy => true
  
  has_many :students
  
  has_many :addresses, :as => :addressable
  has_many :preferred_addresses, :through => :addresses
  accepts_nested_attributes_for :addresses
  
	attr_accessible :email, :first, :last, :telephones_attributes, :addresses_attributes
  
  before_validation { |customer| customer.nameize :first, :last }
  before_validation { |customer| customer.email = customer.email.strip.downcase }
  
	validates :first, presence: true, length: { maximum: 30 }
	#validates :last, presence: true, length: { maximum: 30 }
	#validates :email, presence: true, length: { maximum: 80 }
	#validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
