class AddNewColumnsToReportItems < ActiveRecord::Migration[6.1]
  def change
    add_column :report_items, :event_stream_id, :bigint
    add_column :report_items, :duration, :integer
    add_column :report_items, :time_period, :string
    add_index :report_items, :event_stream_id
  end
end
