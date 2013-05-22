class Instrument < ActiveRecord::Base
  include FieldSanitizer
  has_and_belongs_to_many :teachers
  attr_accessible :name
  before_validation { |instrument| instrument.nameize :name }
end
