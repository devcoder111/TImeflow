# == Schema Information
#
# Table name: event_stream_fields
#
#  id              :bigint           not null, primary key
#  data_type       :string
#  description     :text
#  name            :string
#  required        :boolean
#  stream_type     :string
#  value           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  event_stream_id :bigint           not null
#
# Indexes
#
#  index_event_stream_fields_on_event_stream_id  (event_stream_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_stream_id => event_streams.id)
#
class EventStreamField < ApplicationRecord
  validates_presence_of :name
  belongs_to :event_stream, touch: true
end
