# == Schema Information
#
# Table name: lessons
#
#  id            :integer          not null, primary key
#  student_id    :integer
#  teacher_id    :integer
#  instrument_id :integer
#  room_id       :integer
#  weekday       :integer
#  start_time    :time
#  end_time      :time
#  frequency     :integer
#  start_date    :date
#  end_date      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Lesson do
  pending "add some examples to (or delete) #{__FILE__}"
end
