class AddJobidToSimulations < ActiveRecord::Migration[6.1]
  def change
    add_column :simulations, :sidekiq_job_id, :string
  end
end
