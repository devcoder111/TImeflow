# == Schema Information
#
# Table name: projects
#
#  id              :bigint           not null, primary key
#  description     :text
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organisation_id :bigint           not null
#
# Indexes
#
#  index_projects_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#
class Project < ApplicationRecord
  validates_presence_of :name
  
  belongs_to :organisation

  # after_create :create_default_event_stream

  with_options dependent: :destroy do |assoc|
    assoc.has_many :alerts
    assoc.has_many :reports
    assoc.has_many :event_streams
    assoc.has_many :time_flow_monitors
    assoc.has_many :simulations
  end

  has_many :simulation_fields, through: :simulations

  def create_default_event_stream
    e = self.event_streams.new(name: "ORDERS", description: "this is test order desc")
    e.skip_clickhouse_tables = true
    e.save!

    e.event_stream_fields.create(name: "order_id", data_type: "integer")
    e.event_stream_fields.create(name: "customer_id", data_type: "integer")
    e.event_stream_fields.create(name: "delivery_type", data_type: "string")
    e.event_stream_fields.create(name: "value", data_type: "integer")
  end
end
