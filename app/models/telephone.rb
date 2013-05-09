class Telephone < ActiveRecord::Base

	belongs_to :customer
	attr_accessible :customer_id, :description, :area, :prefix, :sufix

	validates :area, presence: true, length: { minimum: 3 }
	validates :prefix, presence: true, length: { minimum: 3 }
	validates :sufix, presence: true, length: { minimum: 4 }
	validates :description, presence: true
end
