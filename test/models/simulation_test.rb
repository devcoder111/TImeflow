# == Schema Information
#
# Table name: simulations
#
#  id              :bigint           not null, primary key
#  description     :text
#  name            :string
#  replica         :integer
#  simulation_type :integer
#  value           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :bigint           not null
#  sidekiq_job_id  :string
#
# Indexes
#
#  index_simulations_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require "test_helper"

class SimulationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
