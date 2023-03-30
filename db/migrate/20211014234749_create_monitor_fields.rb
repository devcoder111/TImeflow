class CreateMonitorFields < ActiveRecord::Migration[6.1]
  def change
    create_table :monitor_fields do |t|
      t.jsonb :definitions
      t.references :time_flow_monitor, null: false, foreign_key: true
      t.references :time_window, null: false, foreign_key: true
      t.references :event_stream, null: false, foreign_key: true
      t.timestamps
    end
  end
end
