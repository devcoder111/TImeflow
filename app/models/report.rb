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
class Report < ApplicationRecord
  has_many :report_items, inverse_of: :report, dependent: :destroy
  belongs_to :project

  validates_presence_of :name

  accepts_nested_attributes_for :report_items, reject_if: :all_blank, allow_destroy: true
end
