class ChangeColumnRegularExpressionInSimulationFields < ActiveRecord::Migration[6.1]
  def change
    change_column :simulation_fields, :regular_expression, :boolean, default: false
  end
end
