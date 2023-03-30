class AddMonitorIdToAlerts < ActiveRecord::Migration[6.1]
  def change
    add_column :alerts, :time_flow_monitor_id, :string
  end
end