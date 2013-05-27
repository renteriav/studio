# == Schema Information
#
# Table name: instruments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Instrument < ActiveRecord::Base
  include FieldSanitizer
  has_and_belongs_to_many :teachers
  attr_accessible :name
  before_validation { |instrument| instrument.nameize :name }
end
