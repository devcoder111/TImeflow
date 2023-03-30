# == Schema Information
#
# Table name: simulation_fields
#
#  id                 :bigint           not null, primary key
#  delay_type         :integer
#  delay_value        :integer
#  event_definitions  :jsonb
#  position           :integer
#  regular_expression :boolean          default(FALSE)
#  step_name          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  event_stream_id    :integer
#  simulation_id      :bigint           not null
#
# Indexes
#
#  index_simulation_fields_on_event_stream_id  (event_stream_id)
#  index_simulation_fields_on_simulation_id    (simulation_id)
#
# Foreign Keys
#
#  fk_rails_...  (simulation_id => simulations.id)
#
class SimulationField < ApplicationRecord
  belongs_to :simulation
  belongs_to :event_stream

  DELAY_TYPES = ['Static Value', 'Random Value'].freeze

  enum delay_type: DELAY_TYPES
end
