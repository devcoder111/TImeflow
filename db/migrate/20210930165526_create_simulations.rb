class CreateSimulations < ActiveRecord::Migration[6.1]
  def change
    create_table :simulations do |t|
      t.string :name
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
