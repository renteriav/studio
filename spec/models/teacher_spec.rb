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

require 'spec_helper'

describe Teacher do
  pending "add some examples to (or delete) #{__FILE__}"
end
