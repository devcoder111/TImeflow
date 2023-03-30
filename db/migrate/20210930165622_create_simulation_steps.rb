class CreateSimulationSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :simulation_steps do |t|
      t.string :name
      t.text :description
      t.string :sm_type
      t.references :simulation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
