# == Schema Information
#
# Table name: event_streams
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint
#
# Indexes
#
#  index_event_streams_on_project_id  (project_id)
#
require "test_helper"

class EventStreamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
