json.extract! event_stream, :id, :name, :description, :project, :created_at, :updated_at
json.url event_stream_url(event_stream, format: :json)
