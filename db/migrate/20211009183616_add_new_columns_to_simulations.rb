class AddNewColumnsToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :replica, :integer
    add_column :simulations, :simulation_type, :integer
    add_column :simulations, :value, :string
  end
end
