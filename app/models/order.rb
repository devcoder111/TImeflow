# == Schema Information
#
# Table name: ORDERS
#
#  delivery_type :string           not null
#  timestamp     :datetime         not null
#  value         :integer          not null
#  customer_id   :integer          not null
#  order_id      :integer          not null
#
class Order < ApplicationRecord
  establish_connection :clickhouse
  self.table_name = "ORDERS"

  def self.get_aggregated_data_with_minutes
    results = connection.exec_query("select 
      toStartOfMinute( timestamp ) as time, 
      delivery_type, count( value ) as data
      from ORDERS GROUP BY toStartOfMinute( timestamp ), delivery_type")
    results
  end

  def self.get_aggregated_data search_params
    time_frame = search_params["time_frame"]
    if search_params["situation"] == "relative" || search_params["situation"] == "actual"
      condition = "WHERE timestamp #{time_frame == 'next' ? '<' : '>'}= (select date_add(minute, #{time_frame == 'next' ? '+': '-'}#{search_params['duration'] || 0}, now()))"
    end
    query = "select #{search_params['bucketing']}(timestamp) as time, delivery_type, #{search_params['aggregation']}(#{search_params['field_name']}) as data from ORDERS #{condition} GROUP BY #{search_params['bucketing']}(timestamp), delivery_type"
    results = connection.exec_query(query)
  end
end
