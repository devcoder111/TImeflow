class DatasController < ApplicationController
  before_action :set_project
  before_action :authenticate_user!

  def index
    @event_streams = @project.event_streams
    if @event_streams.present?
      @event_stream = @event_streams.first
      @clickhouse_data = KafkaClickhouse.get_all_data(@event_stream)
      @graph_data = KafkaClickhouse.get_aggregated_data_with_minutes @event_stream
    end
  end

  def set_event_stream
    @data = {}
    @event_stream = EventStream.find(params[:event_stream_id])
    @clickhouse_data = KafkaClickhouse.get_all_data @event_stream
    @aggregated_data = KafkaClickhouse.get_aggregated_data_with_minutes @event_stream
    if @aggregated_data
      @data = @aggregated_data.map { |series| [series['time'], series["data"]] }.to_h.to_json.html_safe
    end
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  def search_results
    @data = {}
    @event_stream = EventStream.find(params[:search][:event_stream_id])
    @result = KafkaClickhouse.get_aggregated_data params[:search], @event_stream
    @chart_type = params[:search][:chart_type]
    if @chart_type == 'histogram'
      @aggregated_data = KafkaClickhouse.get_histogram_data(@event_stream, params[:search][:field_to_query].parameterize(separator: '_'))
    else
      @aggregated_data = KafkaClickhouse.get_aggregated_data_with_minutes @event_stream
    end
    if @aggregated_data
      @data = @aggregated_data.map { |series| [series['time'], series["data"]] }.to_h.to_json.html_safe
    end
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
