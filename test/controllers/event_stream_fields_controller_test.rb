require "test_helper"

class EventStreamFieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_stream_field = event_stream_fields(:one)
  end

  test "should get index" do
    get event_stream_fields_url
    assert_response :success
  end

  test "should get new" do
    get new_event_stream_field_url
    assert_response :success
  end

  test "should create event_stream_field" do
    assert_difference('EventStreamField.count') do
      post event_stream_fields_url, params: { event_stream_field: { data_type: @event_stream_field.data_type, description: @event_stream_field.description, event_stream_id: @event_stream_field.event_stream_id, name: @event_stream_field.name, required: @event_stream_field.required, stream_type: @event_stream_field.stream_type } }
    end

    assert_redirected_to event_stream_field_url(EventStreamField.last)
  end

  test "should show event_stream_field" do
    get event_stream_field_url(@event_stream_field)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_stream_field_url(@event_stream_field)
    assert_response :success
  end

  test "should update event_stream_field" do
    patch event_stream_field_url(@event_stream_field), params: { event_stream_field: { data_type: @event_stream_field.data_type, description: @event_stream_field.description, event_stream_id: @event_stream_field.event_stream_id, name: @event_stream_field.name, required: @event_stream_field.required, stream_type: @event_stream_field.stream_type } }
    assert_redirected_to event_stream_field_url(@event_stream_field)
  end

  test "should destroy event_stream_field" do
    assert_difference('EventStreamField.count', -1) do
      delete event_stream_field_url(@event_stream_field)
    end

    assert_redirected_to event_stream_fields_url
  end
end
