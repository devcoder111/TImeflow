class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.text :description
      t.references :project

      t.timestamps
    end
  end
end
