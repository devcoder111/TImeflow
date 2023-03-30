# require 'sidekiq/testing/inline'

class CreateAlertWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(monitor_id)
    monitor = TimeFlowMonitor.find(monitor_id)
    Alert.create(name: "Alert", description: "Alert", project: monitor.project)
  end
end
