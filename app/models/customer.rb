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
	accepts_nested_attributes_for :telephones, :allow_destroy => true, :reject_if => proc { |a| a['number'].blank? }
  
  has_many :students
  
  has_many :addresses, :as => :addressable
  has_many :preferred_addresses, :through => :addresses
  accepts_nested_attributes_for :addresses
  
	attr_accessible :email, :first, :last, :telephones_attributes, :addresses_attributes
  
  before_validation { |customer| customer.nameize :first, :last }
  before_validation { |customer| 
    if customer.email != nil
      customer.email = customer.email.strip.downcase
    end 
  }
  #validates_associated :telephones, presence: { message: "Please enter a valid number." }
  #validates_presence_of :telephones, message: "Enter a valid number"
	validates :first, presence: {message: "Enter first name"}, length: { maximum: 30 } 
	validates :last, presence: {message: "Enter last name"}, length: { maximum: 30 }
	#validates :email, presence: {message: "Enter email"}, length: { maximum: 80 }
  #validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, message: "Enter a valid email"}
end
