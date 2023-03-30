# == Schema Information
#
# Table name: report_items
#
#  id              :bigint           not null, primary key
#  aggregate       :boolean          default(FALSE)
#  data            :jsonb            not null
#  description     :text
#  duration        :integer
#  name            :string
#  report_type     :integer
#  time_period     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_stream_id :bigint
#  report_id       :bigint           not null
#
# Indexes
#
#  index_report_items_on_data             (data) USING gin
#  index_report_items_on_event_stream_id  (event_stream_id)
#  index_report_items_on_report_id        (report_id)
#
# Foreign Keys
#
#  fk_rails_...  (report_id => reports.id)
#
class ReportItem < ApplicationRecord
  include Storext.model

  belongs_to :report
  belongs_to :event_stream

  REPORT_TYPES = ['Data Table', 'Time Series', 'Metric', 'Bar Chart', 'Histogram',
                  'Pie Chart', 'Scatter Plot', 'SQL Query', 'External Source', 'Alerts'].freeze

  enum report_type: REPORT_TYPES

  store_attributes :data do
    filters Array
    aggregation Hash
  end

  # validates_presence_of :name
end
