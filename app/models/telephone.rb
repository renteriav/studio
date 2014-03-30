# == Schema Information
#
# Table name: telephones
#
#  id             :integer          not null, primary key
#  number         :string(255)
#  description    :string(255)
#  phoneable_id   :integer
#  phoneable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Telephone < ActiveRecord::Base

	belongs_to :phoneable, :polymorphic => true
	attr_accessible :number, :description, :phoneable_id, :phoneable_type

  before_validation { |telephone| telephone.number = telephone.number.to_s.gsub(/[^0-9]/, "") }
  
  validates :description, presence: {message: "Select a phone description"}, if: :number_presence?
  
	validates :number, :length => { :is => 10, message: "Enter a valid number" }, if: :number_presence?
  
  def number_presence?
    self.number.present?
  end
end
