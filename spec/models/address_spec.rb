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

require 'spec_helper'

describe Address do
  pending "add some examples to (or delete) #{__FILE__}"
end
