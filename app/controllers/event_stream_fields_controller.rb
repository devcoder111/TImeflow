class EventStreamFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_event_stream_field, only: %i[ show edit update destroy ]

  # GET /event_stream_fields or /event_stream_fields.json
  def index
    @event_stream_fields = EventStreamField.all
  end

  # GET /event_stream_fields/1 or /event_stream_fields/1.json
  def show
  end

  # GET /event_stream_fields/new
  def new
    @event_stream_field = EventStreamField.new
  end

  # GET /event_stream_fields/1/edit
  def edit
  end

  # POST /event_stream_fields or /event_stream_fields.json
  def create
    @event_stream_field = EventStreamField.new(event_stream_field_params)

    respond_to do |format|
      if @event_stream_field.save
        format.html { redirect_to @event_stream_field, notice: "Event stream field was successfully created." }
        format.json { render :show, status: :created, location: @event_stream_field }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_stream_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_stream_fields/1 or /event_stream_fields/1.json
  def update
    respond_to do |format|
      if @event_stream_field.update(event_stream_field_params)
        format.html { redirect_to @event_stream_field, notice: "Event stream field was successfully updated." }
        format.json { render :show, status: :ok, location: @event_stream_field }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_stream_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_stream_fields/1 or /event_stream_fields/1.json
  def destroy
    @event_stream_field.destroy
    respond_to do |format|
      format.html { redirect_to event_stream_fields_url, notice: "Event stream field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_stream_field
      @event_stream_field = EventStreamField.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_stream_field_params
      params.require(:event_stream_field).permit(:name, :description, :event_stream_id, :data_type, :stream_type, :required)
    end
end
