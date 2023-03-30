class CreateTimeFlowMonitors < ActiveRecord::Migration[6.1]
  def change
    create_table :time_flow_monitors do |t|
      t.string :name
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
