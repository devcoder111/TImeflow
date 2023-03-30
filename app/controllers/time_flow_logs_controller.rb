class TimeFlowLogsController < ApplicationController
  before_action :set_project
  before_action :authenticate_user!

  def index
    @logs = TimeFlowLog.where(project_id: params[:project_id]).paginate(page: params[:page], per_page: 30).order('created_at DESC')
  end
end
