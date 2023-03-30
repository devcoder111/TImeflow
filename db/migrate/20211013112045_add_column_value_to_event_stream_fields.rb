class AddColumnValueToEventStreamFields < ActiveRecord::Migration[6.1]
  def change
    add_column :event_stream_fields, :value, :string
  end
end
