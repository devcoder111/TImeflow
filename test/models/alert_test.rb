# == Schema Information
#
# Table name: alerts
#
#  id                    :bigint           not null, primary key
#  alert_condition       :string
#  alert_condition_value :string
#  description           :text
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  project_id            :bigint           not null
#  time_flow_monitor_id  :string
#
# Indexes
#
#  index_alerts_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require "test_helper"

class AlertTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
