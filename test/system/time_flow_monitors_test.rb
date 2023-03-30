require "application_system_test_case"

class TimeFlowMonitorsTest < ApplicationSystemTestCase
  setup do
    @time_flow_monitor = time_flow_monitors(:one)
  end

  test "visiting the index" do
    visit time_flow_monitors_url
    assert_selector "h1", text: "Time Flow Monitors"
  end

  test "creating a Time flow monitor" do
    visit time_flow_monitors_url
    click_on "New Time Flow Monitor"

    fill_in "Description", with: @time_flow_monitor.description
    fill_in "Name", with: @time_flow_monitor.name
    fill_in "Project", with: @time_flow_monitor.project_id
    click_on "Create Time flow monitor"

    assert_text "Time flow monitor was successfully created"
    click_on "Back"
  end

  test "updating a Time flow monitor" do
    visit time_flow_monitors_url
    click_on "Edit", match: :first

    fill_in "Description", with: @time_flow_monitor.description
    fill_in "Name", with: @time_flow_monitor.name
    fill_in "Project", with: @time_flow_monitor.project_id
    click_on "Update Time flow monitor"

    assert_text "Time flow monitor was successfully updated"
    click_on "Back"
  end

  test "destroying a Time flow monitor" do
    visit time_flow_monitors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time flow monitor was successfully destroyed"
  end
end
