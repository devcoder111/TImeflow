# == Schema Information
#
# Table name: monitor_fields
#
#  id                   :bigint           not null, primary key
#  definitions          :jsonb
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  event_stream_id      :bigint           not null
#  time_flow_monitor_id :bigint           not null
#  time_window_id       :bigint           not null
#
# Indexes
#
#  index_monitor_fields_on_event_stream_id       (event_stream_id)
#  index_monitor_fields_on_time_flow_monitor_id  (time_flow_monitor_id)
#  index_monitor_fields_on_time_window_id        (time_window_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_stream_id => event_streams.id)
#  fk_rails_...  (time_flow_monitor_id => time_flow_monitors.id)
#  fk_rails_...  (time_window_id => time_windows.id)
#
class MonitorField < ApplicationRecord

  belongs_to :time_flow_monitor, :class_name => 'TimeFlowMonitor', :foreign_key => 'time_flow_monitor_id'
  belongs_to :time_window, :class_name => 'TimeWindow', :foreign_key => 'time_window_id'
  belongs_to :event_stream, :class_name => 'EventStream', :foreign_key => 'event_stream_id'

  def self.filter_simulation_data simulation_fields_data, definitions
    res = []
    simulation_fields_data.each do |data|
      res << data if all_satisfy(data, definitions)
    end
    res
  end

  def self.all_satisfy(data, definitions)
    definitions.each do |definition|
      next unless definition[:value].present?
      return false unless satisfy(data, definition)
    end
    true
  end

  def self.satisfy(data, definition)
    return false if definition[:condition] == "Equal to" && data[definition[:field].downcase].to_f != definition[:value].to_f
    return false if definition[:condition] == "Greater than" && data[definition[:field].downcase].to_f <= definition[:value].to_f
    return false if definition[:condition] == "Less than" && data[definition[:field].downcase].to_f >= definition[:value].to_f
    return false if definition[:condition] == "Greater than or equal to" && data[definition[:field].downcase].to_f < definition[:value].to_f
    return false if definition[:condition] == "Less than or equal to" && data[definition[:field].downcase].to_f > definition[:value].to_f
    return false if definition[:condition] == "Not equal to" && data[definition[:field].downcase].to_f == definition[:value].to_f
    true
  end
end
