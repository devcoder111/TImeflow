class EventStreamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_event_stream, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  def saved_search
  end

  def external_data_sources
  end

  def simulations_workflow
  end

  def time_series
  end

  def metrics_workflow
  end

  # GET /event_streams or /event_streams.json
  def index
    @event_streams = @project.event_streams
  end

  # GET /event_streams/1 or /event_streams/1.json
  def show
  end

  # GET /event_streams/new
  def new
    @event_stream = EventStream.new
    @event_stream.event_stream_fields.build
  end

  # GET /event_streams/1/edit
  def edit
  end

  # POST /event_streams or /event_streams.json
  def create
    p "In Create"
    p event_stream_params
    @event_stream = EventStream.new(event_stream_params)
    p "In Create"
    @event_stream.project_id = @project.id
    p "In Create"

    respond_to do |format|
      if @event_stream.save
        format.html { redirect_to project_event_streams_path(@project), notice: "Event stream was successfully created." }
        format.json { render :show, status: :created, location: @event_stream }
      else
        p @event_stream.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_streams/1 or /event_streams/1.json
  def update
    respond_to do |format|
      if @event_stream.update(event_stream_params)
        format.html { redirect_to project_event_streams_path(@project), notice: "Event stream was successfully updated." }
        format.json { render :show, status: :ok, location: @event_stream }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_streams/1 or /event_streams/1.json
  def destroy
    @event_stream.destroy
    respond_to do |format|
      format.html { redirect_to project_event_streams_path(@project), notice: "Event stream was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_stream
      @event_stream = @project.event_streams.find(params[:id])
    end

    def set_project
      @project = current_user_projects.find_by_id params[:project_id]

      return redirect_to projects_path unless @project.present?
    end

    # Only allow a list of trusted parameters through.
    def event_stream_params
      params.require(:event_stream).permit(:name,
        :description,
        event_stream_fields_attributes: [:id, :name, :description, :data_type, :stream_type, :required, :_destroy])
    end
end
