# == Schema Information
#
# Table name: time_windows
#
#  id         :bigint           not null, primary key
#  direction  :integer
#  duration   :integer
#  unit       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TimeWindow < ApplicationRecord
  has_one :monitor_field
  UNIT  = [:hours, :seconds, :minutes, :days, :weeks, :months, :years]
  enum unit: UNIT

  DIRECTION  = [:prev, :next]
  enum direction: DIRECTION
end
