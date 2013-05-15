# == Schema Information
#
# Table name: students
#
#  id          :integer          not null, primary key
#  first       :string(255)
#  last        :string(255)
#  cell        :string(255)
#  email       :string(255)
#  birthdate   :date
#  grade       :integer
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Student do
  it "should be valid" do
    Student.new.should be_valid
  end
end
