class CreateTimeWindows < ActiveRecord::Migration[6.1]
  def change
    create_table :time_windows do |t|
      t.string :direction
      t.string :unit
      t.integer :duration
      t.timestamps
    end
  end
end
