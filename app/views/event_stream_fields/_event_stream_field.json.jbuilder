json.extract! event_stream_field, :id, :name, :description, :event_stream_id, :data_type, :stream_type, :required, :created_at, :updated_at
json.url event_stream_field_url(event_stream_field, format: :json)
