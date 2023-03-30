module ReportsHelper
  def display_chart(chart_type, data)
    eval("#{chart_type}(#{data})")
  end

  def get_filtered_data(report_item)    
    conditions = []
    report_item.data['filters'].each do |datum|
      conditions << "#{datum['field'].parameterize(separator: '_')} #{datum['operator']} '#{datum['value']}'"
    end

    if report_item.aggregate?
      results = KafkaClickhouse.get_aggregated_data({'time_frame' => 'next', 'duration' => 0, 'field_name' => 'lucy_ward'}, report_item.event_stream)
    else
      results = KafkaClickhouse.search(report_item.event_stream, conditions.join(' AND '))
    end

    return results
  end
  
end
