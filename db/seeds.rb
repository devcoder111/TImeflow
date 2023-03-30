# p "--"*88
# # Organisation.all.each do |o|
# #   project = Project.create!(name: "this is a seed project", organisation_id: o.id) 
# #   p project
# #   e = event_stream = project.event_streams.new(name: "ORDERS", description: "this is test order desc")
# #   e.skip_clickhouse_tables = true
# #   e.save!
# #   p "event stream"
# #   p e

# #   e.event_stream_fields.create(name: "order_id", data_type: "integer")
# #   e.event_stream_fields.create(name: "customer_id", data_type: "integer")
# #   e.event_stream_fields.create(name: "delivery_type", data_type: "string")
# #   e.event_stream_fields.create(name: "value", data_type: "integer")
# #   p "--"*88
# # end