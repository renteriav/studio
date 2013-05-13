# == Schema Information
#
# Table name: preferred_addresses
#
#  id          :integer          not null, primary key
#  address_id  :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PreferredAddress < ActiveRecord::Base
  
  belongs_to :addresses
  attr_accessible :address_id, :description
end
