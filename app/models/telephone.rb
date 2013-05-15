# == Schema Information
#
# Table name: telephones
#
#  id             :integer          not null, primary key
#  area           :string(255)
#  prefix         :string(255)
#  sufix          :string(255)
#  description    :string(255)
#  phoneable_id   :integer
#  phoneable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Telephone < ActiveRecord::Base

	belongs_to :phoneable, :polymorphic => true
	attr_accessible :area, :prefix, :sufix, :description, :phoneable_id, :phoneable_type

	#validates :area, presence: true, length: { minimum: 3 }
	#validates :prefix, presence: true, length: { minimum: 3 }
	#validates :sufix, presence: true, length: { minimum: 4 }
	#validates :description, presence: true
end
