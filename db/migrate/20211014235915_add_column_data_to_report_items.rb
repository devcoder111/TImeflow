class AddColumnDataToReportItems < ActiveRecord::Migration[6.1]
  def change
    add_column :report_items, :data, :jsonb, null: false, default: {}
    add_index :report_items, :data, using: :gin
  end
end
