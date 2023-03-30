class CreateEventStreams < ActiveRecord::Migration[6.1]
  def change
    create_table :event_streams do |t|
      t.string :name
      t.text :description
      t.references :project

      t.timestamps
    end
  end
end
