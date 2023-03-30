class ChangeColumnSimulationIdInTimeFlowLogs < ActiveRecord::Migration[6.1]
  def change
    change_column :time_flow_logs, :simulation_id, :integer, null: true
  end
end
