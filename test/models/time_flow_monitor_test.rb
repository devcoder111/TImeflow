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
require "test_helper"

class TimeFlowMonitorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
