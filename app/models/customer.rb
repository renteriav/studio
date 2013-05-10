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
	has_many :telephones, :dependent => :destroy
	accepts_nested_attributes_for :telephones, :allow_destroy => true
	attr_accessible :email, :first, :last, :telephones_attributes
	validates :first, presence: true, length: { maximum: 30 }
	validates :last, presence: true, length: { maximum: 30 }
	validates :email, presence: true, length: { maximum: 80 }
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
