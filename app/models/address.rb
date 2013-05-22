# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street           :string(255)
#  city             :string(255)
#  state            :string(255)
#  zip              :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ActiveRecord::Base
  include FieldSanitizer
  belongs_to :addressable, :polymorphic => true
  has_many :preferred_addresses
  accepts_nested_attributes_for :preferred_addresses
  
  attr_accessible :street, :city, :state, :zip, :addressable_id, :addressable_type, :preferred_addresses_attributes
  
  before_validation { |address| address.nameize :street, :city }
  
  validates :street, presence: { message: "Please enter a street name." }
  validates :city, presence: true
  
end

