class AddProjectIdToTimeFlowLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :time_flow_logs, :project_id, :string
  end
end
