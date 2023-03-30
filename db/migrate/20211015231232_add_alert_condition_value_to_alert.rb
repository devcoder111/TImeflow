class AddAlertConditionValueToAlert < ActiveRecord::Migration[6.1]
  def change
    add_column :alerts, :alert_condition_value, :string
  end
end
