# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  street      :string(255)
#  city        :string(255)
#  state       :string(255)
#  zip         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer
#

class Address < ActiveRecord::Base
  
  belongs_to :customers
  has_many :preferred_addresses
  accepts_nested_attributes_for :preferred_addresses
  
  attr_accessible :city, :state, :street, :zip, :preferred_addresses_attributes
end

