class AddColumnAggregateToReportItems < ActiveRecord::Migration[6.1]
  def change
    add_column :report_items, :aggregate, :boolean, default: false
  end
end
