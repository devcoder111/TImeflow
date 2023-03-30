class AddAlertConditionToAlert < ActiveRecord::Migration[6.1]
  def change
    add_column :alerts, :alert_condition, :string
  end
end
