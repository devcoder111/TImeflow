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
class Alert < ApplicationRecord
  belongs_to :project
  belongs_to :time_flow_monitor

  def self.create_list_for(project)
    # (1..10).to_a.each do |n|
    #   create(name: "Alert-#{n}", description: "Alert-#{n} DESC", project: project)
    # end
  end
end
