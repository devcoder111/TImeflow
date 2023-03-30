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
require "test_helper"

class ReportItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
