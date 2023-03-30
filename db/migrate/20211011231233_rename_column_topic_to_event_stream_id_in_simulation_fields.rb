class RenameColumnTopicToEventStreamIdInSimulationFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :simulation_fields, :topic
    add_column :simulation_fields, :event_stream_id, :integer
    add_index :simulation_fields, :event_stream_id
  end
end
