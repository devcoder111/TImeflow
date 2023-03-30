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

class Simulation < ApplicationRecord
  has_many :simulation_fields, inverse_of: :simulation, dependent: :destroy
  has_many :time_flow_logs, dependent: :nullify
  belongs_to :project

  RUN_TYPES  = {
    'Run Once' => 1,
    'Run Specified Number Of Time' => 2,
    'Run Continously' => 3,
    'Run For Specified Time Period (In Minutes)' => 4
  }

  accepts_nested_attributes_for :simulation_fields, reject_if: :all_blank, allow_destroy: true

  validates :name, :replica, :simulation_type, presence: true
  validates :replica, numericality: { only_integer: true }

  enum simulation_type: RUN_TYPES

  def start(current_user_id)
    begin
      self.simulation_fields.each do |sf|
        event_stream_name = sf.event_stream.name.parameterize(separator: '_')
        p "Launching Async job as user with ID #{current_user_id}"
        topic = "#{current_user_id}_#{self.project_id}_#{event_stream_name}"

        payload = {}
        if sf.regular_expression?
          sf.event_definitions.each do |k, v|
            random_string = Faker::Base.regexify(v)
            payload[k] = random_string
          end
        else
          payload = sf.event_definitions
        end
        payload['timestamp'] = Time.current.strftime("%Y-%m-%d %H:%M:%S")
        $kafka_producer.produce(payload.to_json, topic: topic)
        $kafka_producer.deliver_messages
        $kafka_producer.shutdown
      end
    rescue StandardError => e
      Rails.logger.error (["#{self.class} - #{e.class}: #{e.message}"]+e.backtrace).join("\n")
    end
  end
end
