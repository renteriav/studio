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

class Student < ActiveRecord::Base
  attr_accessible :first, :last, :cell, :email, :birthdate, :grade, :customer_id
end
