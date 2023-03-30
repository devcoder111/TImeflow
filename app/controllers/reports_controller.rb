class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_report, only: %i[ show edit update destroy ]

  # GET /reports or /reports.json
  def index
    @reports = @project.reports
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    @report.report_items.build
    gon.project_id = @project.id
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)
    @report.project = @project

    respond_to do |format|
      if @report.save
        format.html { redirect_to project_reports_path(@project), notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to project_reports_path(@project), notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to project_reports_path(@project), notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def event_stream_fields
    @event_stream = EventStream.find(params[:event_stream_id])
    @element_number = params[:element_number]
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = @project.reports.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:name, :description, report_items_attributes: [:name, :event_stream_id, 
                                                                                    :duration, :time_period, 
                                                                                    data: {filters: [:field, :operator, :value]}])
    end
end
