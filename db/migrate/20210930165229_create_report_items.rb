class CreateReportItems < ActiveRecord::Migration[6.1]
  def change
    create_table :report_items do |t|
      t.string :name
      t.text :description
      t.references :report, null: false, foreign_key: true
      t.string :report_type

      t.timestamps
    end
  end
end
