class ChangeColumnTypeOfReportTypeInReportItems < ActiveRecord::Migration[6.1]
  def change
    change_column :report_items, :report_type, 'integer USING CAST(report_type AS integer)'
  end
end
