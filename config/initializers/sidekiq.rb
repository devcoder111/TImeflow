require 'sidekiq'

redis_conn = proc {
  Redis.new({ :namespace => ENV['APP_NAME'], :size => 25, :url => ENV['REDIS_URL'] })
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end