# require 'sidekiq/testing/inline'

class PauseSimulationWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(simulation_id, tid)
    simulation = Simulation.find(simulation_id)
    simulation.update(sidekiq_job_id: nil)
    puts "I'm %s, and I'll be terminating TID: %s..." % [self.class, tid]
    Thread.list.each {|t|
      if t.object_id.to_s == tid
        puts "Goodbye %s!" % t
        t.exit
      end
    }
  end
end