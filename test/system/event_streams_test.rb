require "application_system_test_case"

class EventStreamsTest < ApplicationSystemTestCase
  setup do
    @event_stream = event_streams(:one)
  end

  test "visiting the index" do
    visit event_streams_url
    assert_selector "h1", text: "Event Streams"
  end

  test "creating a Event stream" do
    visit event_streams_url
    click_on "New Event Stream"

    fill_in "Description", with: @event_stream.description
    fill_in "Name", with: @event_stream.name
    fill_in "Project", with: @event_stream.project
    click_on "Create Event stream"

    assert_text "Event stream was successfully created"
    click_on "Back"
  end

  test "updating a Event stream" do
    visit event_streams_url
    click_on "Edit", match: :first

    fill_in "Description", with: @event_stream.description
    fill_in "Name", with: @event_stream.name
    fill_in "Project", with: @event_stream.project
    click_on "Update Event stream"

    assert_text "Event stream was successfully updated"
    click_on "Back"
  end

  test "destroying a Event stream" do
    visit event_streams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event stream was successfully destroyed"
  end
end
