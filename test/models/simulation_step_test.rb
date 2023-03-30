# == Schema Information
#
# Table name: simulation_steps
#
#  id            :bigint           not null, primary key
#  description   :text
#  name          :string
#  sm_type       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  simulation_id :bigint           not null
#
# Indexes
#
#  index_simulation_steps_on_simulation_id  (simulation_id)
#
# Foreign Keys
#
#  fk_rails_...  (simulation_id => simulations.id)
#
require "test_helper"

class SimulationStepTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
