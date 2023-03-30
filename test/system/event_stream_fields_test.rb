require "application_system_test_case"

class EventStreamFieldsTest < ApplicationSystemTestCase
  setup do
    @event_stream_field = event_stream_fields(:one)
  end

  test "visiting the index" do
    visit event_stream_fields_url
    assert_selector "h1", text: "Event Stream Fields"
  end

  test "creating a Event stream field" do
    visit event_stream_fields_url
    click_on "New Event Stream Field"

    fill_in "Data type", with: @event_stream_field.data_type
    fill_in "Description", with: @event_stream_field.description
    fill_in "Event stream", with: @event_stream_field.event_stream_id
    fill_in "Name", with: @event_stream_field.name
    check "Required" if @event_stream_field.required
    fill_in "Stream type", with: @event_stream_field.stream_type
    click_on "Create Event stream field"

    assert_text "Event stream field was successfully created"
    click_on "Back"
  end

  test "updating a Event stream field" do
    visit event_stream_fields_url
    click_on "Edit", match: :first

    fill_in "Data type", with: @event_stream_field.data_type
    fill_in "Description", with: @event_stream_field.description
    fill_in "Event stream", with: @event_stream_field.event_stream_id
    fill_in "Name", with: @event_stream_field.name
    check "Required" if @event_stream_field.required
    fill_in "Stream type", with: @event_stream_field.stream_type
    click_on "Update Event stream field"

    assert_text "Event stream field was successfully updated"
    click_on "Back"
  end

  test "destroying a Event stream field" do
    visit event_stream_fields_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event stream field was successfully destroyed"
  end
end
