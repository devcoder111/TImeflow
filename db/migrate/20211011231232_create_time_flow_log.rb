class CreateTimeFlowLog < ActiveRecord::Migration[6.1]
  def change
    create_table :time_flow_logs do |t|
      t.string :title
      t.references :simulation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
