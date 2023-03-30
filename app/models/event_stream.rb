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
class EventStream < ApplicationRecord

  FIELD_TYPES = ['String', 'Integer', 'Float', 'Boolean', 'Timestamp', 'Date'].freeze
  DATA_TYPES  = ['Categorical', 'Continuous'].freeze
  LIST_ICONS = ['75.png', '76.png', '84.png', '78.png', '79.png', '80.png', '81.png', '82.png', '83.png'].freeze

  validates_presence_of :name
  with_options dependent: :destroy do |assoc|
    assoc.has_many :simulation_fields
    assoc.has_many :event_stream_fields
    assoc.has_many :event_streams
  end

  belongs_to :project, touch: true
  belongs_to :monitor_field, optional: true

  accepts_nested_attributes_for :event_stream_fields, reject_if: :all_blank, allow_destroy: true

  after_create :create_clickhouse_tables, unless: :skip_clickhouse_tables
  attr_accessor :skip_clickhouse_tables

  def create_clickhouse_tables
    p "Creating Clickhouse tables"
    KafkaClickhouse.create_tables self
    p "Clickhouse table creation complete"
  end

end
