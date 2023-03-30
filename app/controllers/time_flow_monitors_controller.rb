class TimeFlowMonitorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, except: %i[ event_definitions ]
  before_action :event_streams, except: %i[ index destroy event_definitions ]
  before_action :set_time_flow_monitor, only: %i[ show edit update destroy start pause]

  # GET /time_flow_monitors or /time_flow_monitors.json
  def index
    @time_flow_monitors = @project.time_flow_monitors
  end

  # GET /time_flow_monitors/1 or /time_flow_monitors/1.json
  def show
  end

  # GET /time_flow_monitors/new
  def new
    @time_flow_monitor = TimeFlowMonitor.new
  end

  # GET /time_flow_monitors/1/edit
  def edit
    if @time_flow_monitor.monitor_field.present?
      @monitor_field = @time_flow_monitor.monitor_field
      @event_stream = @time_flow_monitor.monitor_field.event_stream
      @event_definitions = @time_flow_monitor.monitor_field.definitions
      @alert = @time_flow_monitor.alert
    end
  end

  # POST /time_flow_monitors or /time_flow_monitors.json
  def create
    @event_stream = EventStream.find(params[:event_stream])

    @time_flow_monitor = TimeFlowMonitor.new(time_flow_monitor_params)
    @time_flow_monitor.project = @project
    event_stream_fields = @event_stream.event_stream_fields
    definitions = []
    event_stream_fields.each_with_index do |e,i|
      definitions <<  {field: e.name, condition: params["operator-#{i}"], value:  params["value-#{i}"]}
    end
    timewindow = TimeWindow.create(direction: TimeWindow.directions[params["prev_next"].downcase.to_sym], duration: params["time-duration"], unit: TimeWindow.units[params["time_unit"].downcase.to_sym])
    @monitor_field = MonitorField.create(time_window_id: timewindow.id, time_flow_monitor: @time_flow_monitor, definitions: definitions, event_stream: @event_stream)
    @monitor_field.update(time_window: timewindow)
    @time_flow_monitor.update(monitor_field: @monitor_field)
    if params["alert"].present?
      Alert.create(name: params["alert"]["name"], description: params["alert"]["description"], time_flow_monitor_id: @time_flow_monitor.id, project_id: @time_flow_monitor.project_id, alert_condition: params["alert"]["alert_condition"], alert_condition_value: params["alert"]["alert_condition_value"]  )
    end
    respond_to do |format|
      if @time_flow_monitor.save
        format.html { redirect_to project_time_flow_monitors_path(@project), notice: "Time flow monitor was successfully created." }
        format.json { render :show, status: :created, location: @time_flow_monitor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @time_flow_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_flow_monitors/1 or /time_flow_monitors/1.json
  def update
    MonitorField.where(time_flow_monitor_id: @time_flow_monitor.id).destroy_all if @time_flow_monitor.present?
    TimeWindow.where(monitor_field: @monitor_field.id).destroy_all if @monitor_field.present?
    Alert.where(time_flow_monitor_id: @time_flow_monitor.id).destroy_all if @time_flow_monitor.present?

    @event_stream = EventStream.find(params[:event_stream])
    event_stream_fields = @event_stream.event_stream_fields

    definitions = []
    event_stream_fields.each_with_index do |e,i|
      definitions <<  {field: e.name, condition: params["operator-#{i}"], value:  params["value-#{i}"]}
    end

    timewindow = TimeWindow.create(direction: TimeWindow.directions[params["prev_next"].downcase.to_sym], duration: params["time-duration"], unit: TimeWindow.units[params["time_unit"].downcase.to_sym])
    @monitor_field = MonitorField.create(time_window_id: timewindow.id, time_flow_monitor: @time_flow_monitor, definitions: definitions, event_stream: @event_stream)
    @monitor_field.update(time_window: timewindow)
    @time_flow_monitor.update(monitor_field: @monitor_field)
    if params["alert"].present?
      Alert.create(name: params["alert"]["name"], description: params["alert"]["description"], time_flow_monitor_id: @time_flow_monitor.id, project_id: @time_flow_monitor.project_id, alert_condition: params["alert"]["alert_condition"], alert_condition_value: params["alert"]["alert_condition_value"]  )
    end
    respond_to do |format|
      if @time_flow_monitor.update(time_flow_monitor_params)
        format.html { redirect_to project_time_flow_monitors_path(@project), notice: "Time flow monitor was successfully updated." }
        format.json { render :show, status: :ok, location: @time_flow_monitor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @time_flow_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_flow_monitors/1 or /time_flow_monitors/1.json
  def destroy
    @time_flow_monitor.destroy
    respond_to do |format|
      format.html { redirect_to project_time_flow_monitors_path(@project), notice: "Time flow monitor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def start
    job = Sidekiq::Cron::Job.new(name: 'CreateAlertWorker - every 10s', cron: '*/10 * * * * *', args: @time_flow_monitor.id, class: 'CreateAlertWorker')
    if job.valid?
      @time_flow_monitor.update(sidekiq_job_id: 1)
      job.save
      job.enable!
    else
      puts job.errors
    end
    render json: {
      status: "scheduled"
    }
  end

  def pause
    job = Sidekiq::Cron::Job.find('CreateAlertWorker - every 10s')
    @time_flow_monitor.update(sidekiq_job_id: nil)
    job.disable!
    render json: {
      status: "disabled"
    }
  end

  def event_definitions
    @event_stream = EventStream.find(params[:id])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def preview
    @event_stream = EventStream.find(params[:event_stream_id])
    # build monitor fields
    event_stream_fields = @event_stream.event_stream_fields
    definitions = []
    event_stream_fields.each_with_index do |e,i|
      definitions <<  {field: e.name, condition: params["operator-#{i}"], value:  params["value-#{i}"]}
    end

    # build monitor fields

    @response = KafkaClickhouse.get_all_data(@event_stream)

    @rows = @response.rows
    @columns = @response.columns
    @total_records = @rows.count

    #filter
    data = []
    @rows.each do |r|
      data << Hash[@columns.zip(r)]
    end
    @rows = (MonitorField.filter_simulation_data(data, definitions)).collect { |t| t.values}

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_flow_monitor
      @time_flow_monitor = @project.time_flow_monitors.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_flow_monitor_params
      params.require(:time_flow_monitor).permit(:name, :description)
    end

    def event_streams
      @event_streams ||= @project.event_streams.pluck(:name, :id)
    end
end
