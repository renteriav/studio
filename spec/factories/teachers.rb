# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  first      :string(255)
#  last       :string(255)
#  email      :string(255)
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher do
    first "MyString"
    last "MyString"
    email "MyString"
    address_id 1
    telephone_id 1
  end
end
