class ReportItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report_item, only: %i[ show edit update destroy ]

  # GET /report_items or /report_items.json
  def index
    @report_items = ReportItem.all
  end

  # GET /report_items/1 or /report_items/1.json
  def show
  end

  # GET /report_items/new
  def new
    @report_item = ReportItem.new
  end

  # GET /report_items/1/edit
  def edit
  end

  # POST /report_items or /report_items.json
  def create
    @report_item = ReportItem.new(report_item_params)

    respond_to do |format|
      if @report_item.save
        format.html { redirect_to @report_item, notice: "Report item was successfully created." }
        format.json { render :show, status: :created, location: @report_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_items/1 or /report_items/1.json
  def update
    respond_to do |format|
      if @report_item.update(report_item_params)
        format.html { redirect_to @report_item, notice: "Report item was successfully updated." }
        format.json { render :show, status: :ok, location: @report_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_items/1 or /report_items/1.json
  def destroy
    @report_item.destroy
    respond_to do |format|
      format.html { redirect_to report_items_url, notice: "Report item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_item
      @report_item = ReportItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_item_params
      params.require(:report_item).permit(:name, :description, :report_id, :report_type)
    end
end
