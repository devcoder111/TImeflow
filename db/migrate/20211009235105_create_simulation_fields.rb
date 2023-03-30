class CreateSimulationFields < ActiveRecord::Migration[6.1]
  def change
    create_table :simulation_fields do |t|
      t.string :step_name
      t.string :topic
      t.jsonb :event_definitions
      t.integer :delay_type
      t.integer :delay_value
      t.integer :position
      t.boolean :regular_expression
      t.references :simulation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
