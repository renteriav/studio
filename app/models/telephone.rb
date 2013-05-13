# == Schema Information
#
# Table name: telephones
#
#  id          :integer          not null, primary key
#  area        :string(255)
#  sufix       :string(255)
#  prefix      :string(255)
#  description :string(255)
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Telephone < ActiveRecord::Base

	belongs_to :customer
	attr_accessible :customer_id, :description, :area, :prefix, :sufix

	#validates :area, presence: true, length: { minimum: 3 }
	#validates :prefix, presence: true, length: { minimum: 3 }
	#validates :sufix, presence: true, length: { minimum: 4 }
	#validates :description, presence: true
end
