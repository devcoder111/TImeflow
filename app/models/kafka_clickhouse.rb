class KafkaClickhouse < ApplicationRecord
  establish_connection :clickhouse

  # TODO - Load from environment variable, default to hard coded one
  kafka_bootstrap_url = "134.209.20.12:9092"
  clickhouse_connection_url = "134.209.20.12:9000"

  def self.get_base_table_name event_stream
    "#{event_stream.project.organisation.user.id}_#{event_stream.project_id}_#{event_stream.name.parameterize(separator: '_')}"
  end

  def self.create_kafka_topic( event_stream )
    kafka = Kafka.new(ENV['KAFKA_HOST'])
    kafka.create_topic(get_base_table_name(event_stream))
  end

  def self.create_raw_table(fields_to_create, event_stream)
    begin
      query = "create table #{get_base_table_name(event_stream)} ( #{fields_to_create} ) Engine=MergeTree partition by toYYYYMM(timestamp) order by #{event_stream.event_stream_fields.first.name.parameterize(separator: '_')}"
      p "Executing query:: create_raw_table - #{query}"
      connection.execute(query)
    rescue => e
      p "Exception in create_raw_table :: #{e}"
    end
  end

  def self.create_kafka_queue_table(fields_to_create, event_stream)
    begin
      table_name = get_base_table_name(event_stream)
      kafka_queue_query = "CREATE TABLE #{table_name}_queue( #{fields_to_create} ) engine = Kafka
      settings kafka_broker_list = '#{ENV['KAFKA_HOST']}', kafka_topic_list='#{table_name}', kafka_format = 'JSONEachRow',
      kafka_max_block_size= 1048576, kafka_group_name = 'Clickhouse', kafka_num_consumers = 1"
      p "Executing query:: create_kafka_queue_table - #{kafka_queue_query}"
      connection.execute(kafka_queue_query)
    rescue => e
      p "Exception in create_kafka_queue_table :: #{e}"
    end
  end

  def self.create_materialized_view(fields_to_create, event_stream)
    begin
      table_name = get_base_table_name(event_stream)
      materialized_view_query = "create materialized view #{table_name}_queue_mv to #{table_name} as select timestamp, #{event_stream.event_stream_fields.pluck('name').join(',').downcase.gsub(' ','_')} from #{table_name}_queue"
      p "Executing query::create_materialized_view - #{materialized_view_query}"
      connection.execute(materialized_view_query)
    rescue => e
      p "Exception in create_materialized_view :: #{e}"
    end
  end

  def self.create_tables event_stream
    begin

      p "Creating Clickhouse tables for new event stream"

      fields_to_create = "timestamp timestamp"
      fields = event_stream.event_stream_fields.map { |field|
        fields_to_create += ", #{field.name.parameterize(separator: '_')} #{field.stream_type == "string" ? "varchar" : field.stream_type}"
      }

      # create base table for clickhouse
      create_raw_table(fields_to_create, event_stream)


      # Create kafka queue table to listen to kafka from clickhouse
      create_kafka_topic( event_stream )
      create_kafka_queue_table(fields_to_create, event_stream)
      # CREATE THE MATERIALIZED VIEW WHICH CONNECTS THE TWO
      create_materialized_view(fields_to_create, event_stream)

    rescue => exception
      p "Exception Occured :: #{exception}"
    end
  end

  # def self.get_aggregated_data search_params
  #   time_frame = search_params["time_frame"]
  #   if search_params["situation"] == "relative" || search_params["situation"] == "actual"
  #     condition = "WHERE timestamp #{time_frame == 'next' ? '<' : '>'}= (select date_add(minute, #{time_frame == 'next' ? '+': '-'}#{search_params['duration'] || 0}, now()))"
  #   end
  #   query = "select #{search_params['bucketing']}(timestamp) as time, delivery_type, #{search_params['aggregation']}(#{search_params['field_name']}) as data from ORDERS #{condition} GROUP BY #{search_params['bucketing']}(timestamp), delivery_type"
  #   results = connection.exec_query(query)
  # end

  def self.get_all_data event_stream
    begin
      query = "select * from #{get_base_table_name(event_stream)} OFFSET 0"
      results = connection.select_all(query)
      results
    rescue => exception
      p "Exception occured in create_tables :: #{exception}"
      return []
    end
  end

  def self.get_aggregated_data_with_minutes event_stream
    begin
      aggregation_field = "#{event_stream.event_stream_fields.first.name.parameterize(separator: '_')}"
      query = "select toStartOfMinute( timestamp ) as time, count( '#{aggregation_field}' ) as data from #{get_base_table_name(event_stream)} GROUP BY toStartOfMinute( timestamp ) LIMIT 100 OFFSET 0"
      results = connection.exec_query(query)
      results
    rescue => exception
      p "Exception occured :: #{exception}"
      return []
    end
  end

  def self.get_histogram_data event_stream, field
    field_to_group = field.parameterize(separator: '_')
    query = "select #{field_to_group}, count(*) as data from #{get_base_table_name(event_stream)} group by #{field_to_group}"
    results = connection.exec_query(query)
  end

  def self.get_aggregated_data search_params, event_stream
    fields_to_query = event_stream.event_stream_fields.pluck("name").join(",").downcase.gsub(' ','_')
    time_frame = search_params["time_frame"]
    condition = "WHERE timestamp #{time_frame == 'next' ? '<' : '>'}= (select date_add(minute, #{time_frame == 'next' ? '+': '-'}#{search_params['duration'] || 0}, now()))"
    field_to_aggregate = "#{search_params['field_name'] || event_stream.event_stream_fields.first.name.parameterize(separator: '_')}"
    query = "select timestamp as time, count(#{field_to_aggregate}) as data from #{get_base_table_name(event_stream)} #{condition} GROUP BY timestamp LIMIT 100 OFFSET 0"
    results = connection.exec_query(query)
  end

  def self.search(event_stream, condition)
    query = "SELECT * FROM #{get_base_table_name(event_stream)} WHERE #{condition}"
    results = connection.exec_query(query)
  end

end
