# == Schema Information
#
# Table name: time_flow_monitors
#
#  id             :bigint           not null, primary key
#  description    :text
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  project_id     :bigint           not null
#  sidekiq_job_id :string
#
# Indexes
#
#  index_time_flow_monitors_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
class TimeFlowMonitor < ApplicationRecord
  has_one :alert
  belongs_to :project
  has_one :monitor_field
  has_one :time_window
end
