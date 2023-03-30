class SimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, except: %i[simulation_status event_definitions]
  before_action :set_simulation, only: %i[ show edit update destroy start pause ]

  # GET /simulations or /simulations.json
  def index
    @simulations = Simulation.where(project_id: params[:project_id])
  end

  # GET /simulations/1 or /simulations/1.json
  def show
  end

  # GET /simulations/new
  def new
    @simulation = @project.simulations.new
    @simulation.simulation_fields.build
  end

  # GET /simulations/1/edit
  def edit
  end

  # POST /simulations or /simulations.json
  def create
    @simulation = @project.simulations.new(simulation_params)

    respond_to do |format|
      if @simulation.save
        format.html { redirect_to project_simulations_path(@project), notice: "Simulation was successfully created." }
        format.json { render :show, status: :created, location: @simulation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /simulations/1 or /simulations/1.json
  def update
    respond_to do |format|
      if @simulation.update(simulation_params)
        format.html { redirect_to edit_project_simulation_path(@project, @simulation), notice: "Simulation was successfully updated." }
        format.json { render :show, status: :ok, location: @simulation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  def start
    job_id = StartSimulationWorker.perform_async(params[:id], User.current.id)
    TimeFlowLog.create(simulation_id: params[:id], project_id: params[:project_id], title: "Simulation #{@simulation.name} started")
    @simulation.update(sidekiq_job_id: job_id)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def pause
    job_id = @simulation.sidekiq_job_id
    TimeFlowLog.create(simulation_id: params[:id], project_id: @simulation.project_id, title: "Simulation #{@simulation.name} paused")
    PauseSimulationWorker.perform_async(params[:id], job_id)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  #later
  def simulation_status
    respond_to do |format|
      format.json do
        job_id = params[:job_id]
        job_status = Sidekiq::Status.get_all(job_id).symbolize_keys
        render json: {
          status: job_status[:status],
          percentage: job_status[:pct_complete]
        }
      end
    end
  end


  # DELETE /simulations/1 or /simulations/1.json
  def destroy
    @simulation.destroy
    respond_to do |format|
      format.html { redirect_to project_simulations_url(@project), notice: "Simulation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def event_definitions
    @event_stream = EventStream.find(params[:id])
    @element_number = params[:element_number]
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simulation
      @simulation = Simulation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def simulation_params
      params.require(:simulation).permit(:name, :replica, :simulation_type, :description, :project_id, :value,
                                          simulation_fields_attributes: [:id, :delay_type, :delay_value,
                                                                          :position, :regular_expression,
                                                                          :step_name, :event_stream_id,
                                                                          :_destroy, event_definitions: {}])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
