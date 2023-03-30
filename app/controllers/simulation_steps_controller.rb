class SimulationStepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_simulation_step, only: %i[ show edit update destroy ]

  # GET /simulation_steps or /simulation_steps.json
  def index
    @simulation_steps = SimulationStep.all
  end

  # GET /simulation_steps/1 or /simulation_steps/1.json
  def show
  end

  # GET /simulation_steps/new
  def new
    @simulation_step = SimulationStep.new
  end

  # GET /simulation_steps/1/edit
  def edit
  end

  # POST /simulation_steps or /simulation_steps.json
  def create
    @simulation_step = SimulationStep.new(simulation_step_params)

    respond_to do |format|
      if @simulation_step.save
        format.html { redirect_to @simulation_step, notice: "Simulation step was successfully created." }
        format.json { render :show, status: :created, location: @simulation_step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @simulation_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /simulation_steps/1 or /simulation_steps/1.json
  def update
    respond_to do |format|
      if @simulation_step.update(simulation_step_params)
        format.html { redirect_to @simulation_step, notice: "Simulation step was successfully updated." }
        format.json { render :show, status: :ok, location: @simulation_step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @simulation_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /simulation_steps/1 or /simulation_steps/1.json
  def destroy
    @simulation_step.destroy
    respond_to do |format|
      format.html { redirect_to simulation_steps_url, notice: "Simulation step was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simulation_step
      @simulation_step = SimulationStep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def simulation_step_params
      params.require(:simulation_step).permit(:name, :description, :sm_type, :simulation_id)
    end
end
