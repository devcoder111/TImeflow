class CreateEventStreamFields < ActiveRecord::Migration[6.1]
  def change
    create_table :event_stream_fields do |t|
      t.string :name
      t.text :description
      t.references :event_stream, null: false, foreign_key: true
      t.string :data_type
      t.string :stream_type
      t.boolean :required

      t.timestamps
    end
  end
end
