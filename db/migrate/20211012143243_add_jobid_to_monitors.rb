class AddJobidToMonitors < ActiveRecord::Migration[6.1]
  def change
    add_column :time_flow_monitors, :sidekiq_job_id, :string
  end
end