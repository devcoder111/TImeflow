# config/initializers/kafka_producer.rb
require "kafka"

# Configure the Kafka client with the broker hosts and the Rails
# logger.
$kafka = Kafka.new(ENV['KAFKA_HOST'], client_id: ENV['KAFKA_CLIENT_ID'], logger: Rails.logger)

# Set up an asynchronous producer that delivers its buffered messages
# every ten seconds:
$kafka_producer = $kafka.async_producer(
  compression_codec: :gzip,
  compression_threshold: 10,
  # delivery_interval: 10,
)

# Make sure to shut down the producer when exiting.
at_exit { $kafka_producer.shutdown }
