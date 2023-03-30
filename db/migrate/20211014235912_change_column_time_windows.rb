class ChangeColumnTimeWindows < ActiveRecord::Migration[6.1]
  def change
    change_column :time_windows, :direction, 'integer USING CAST(direction AS integer)'
    change_column :time_windows, :unit, 'integer USING CAST(unit AS integer)'

  end
end
