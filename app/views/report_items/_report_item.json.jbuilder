json.extract! report_item, :id, :name, :description, :report_id, :report_type, :created_at, :updated_at
json.url report_item_url(report_item, format: :json)
