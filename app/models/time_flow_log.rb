# == Schema Information
#
# Table name: time_flow_logs
#
#  id            :bigint           not null, primary key
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :string
#  simulation_id :integer
#
# Indexes
#
#  index_time_flow_logs_on_simulation_id  (simulation_id)
#
# Foreign Keys
#
#  fk_rails_...  (simulation_id => simulations.id)
#
class TimeFlowLog < ApplicationRecord
  belongs_to :simulation, optional: true
end
