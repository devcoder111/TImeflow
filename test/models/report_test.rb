# == Schema Information
#
# Table name: reports
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
#  index_reports_on_project_id  (project_id)
#
require "test_helper"

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
