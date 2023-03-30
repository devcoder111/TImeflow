require "test_helper"

class EventStreamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_stream = event_streams(:one)
  end

  test "should get index" do
    get event_streams_url
    assert_response :success
  end

  test "should get new" do
    get new_event_stream_url
    assert_response :success
  end

  test "should create event_stream" do
    assert_difference('EventStream.count') do
      post event_streams_url, params: { event_stream: { description: @event_stream.description, name: @event_stream.name, project: @event_stream.project } }
    end

    assert_redirected_to event_stream_url(EventStream.last)
  end

  test "should show event_stream" do
    get event_stream_url(@event_stream)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_stream_url(@event_stream)
    assert_response :success
  end

  test "should update event_stream" do
    patch event_stream_url(@event_stream), params: { event_stream: { description: @event_stream.description, name: @event_stream.name, project: @event_stream.project } }
    assert_redirected_to event_stream_url(@event_stream)
  end

  test "should destroy event_stream" do
    assert_difference('EventStream.count', -1) do
      delete event_stream_url(@event_stream)
    end

    assert_redirected_to event_streams_url
  end
end
