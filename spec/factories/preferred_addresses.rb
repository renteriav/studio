# == Schema Information
#
# Table name: preferred_addresses
#
#  id          :integer          not null, primary key
#  address_id  :integer
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :preferred_address do
    address_id "MyString"
    description "MyString"
  end
end
