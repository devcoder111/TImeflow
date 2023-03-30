json.extract! report, :id, :name, :description, :project, :created_at, :updated_at
json.url report_url(report, format: :json)
