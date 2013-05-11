# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  customer_id :string(255)
#  address_id  :string(255)
#  description :string(255)
#  start_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Address < ActiveRecord::Base
  
  has_many :address_details
  has_many :customers, :through => :address_details
  
  attr_accessible :city, :state, :street, :zip
end
