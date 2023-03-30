#require 'sidekiq/testing/inline'

class StartSimulationWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: 'critical'

  def perform(simulation_id, current_user_id)
    simulation = Simulation.find(simulation_id)
    case Simulation::RUN_TYPES[simulation.simulation_type]
    when 1
      simulation.start(current_user_id)
    when 2
      number = simulation.value.to_i
      number.times do |i|
        simulation.start(current_user_id)
      end
    when 3
      loop do
        simulation.start(current_user_id)
        simulation.reload
        break if simulation.sidekiq_job_id.nil?
      end
    when 4
      number = simulation.value.to_i
      time_period = number.minutes.from_now
      while Time.current <= time_period
        simulation.start(current_user_id)
      end
    end

    PauseSimulationWorker.perform_async(simulation.id, simulation.sidekiq_job_id)
  end
end
