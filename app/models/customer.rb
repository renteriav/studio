class Customer < ActiveRecord::Base
	has_many :telephones, :dependent => :destroy
	accepts_nested_attributes_for :telephones, :allow_destroy => true
	attr_accessible :email, :first, :last, :telephones_attributes
	validates :first, presence: true, length: { maximum: 30 }
	validates :last, presence: true, length: { maximum: 30 }
	validates :email, presence: true, length: { maximum: 80 }
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
