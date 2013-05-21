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
