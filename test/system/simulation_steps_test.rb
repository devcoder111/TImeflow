require "application_system_test_case"

class SimulationStepsTest < ApplicationSystemTestCase
  setup do
    @simulation_step = simulation_steps(:one)
  end

  test "visiting the index" do
    visit simulation_steps_url
    assert_selector "h1", text: "Simulation Steps"
  end

  test "creating a Simulation step" do
    visit simulation_steps_url
    click_on "New Simulation Step"

    fill_in "Description", with: @simulation_step.description
    fill_in "Name", with: @simulation_step.name
    fill_in "Simulation", with: @simulation_step.simulation_id
    fill_in "Sm type", with: @simulation_step.sm_type
    click_on "Create Simulation step"

    assert_text "Simulation step was successfully created"
    click_on "Back"
  end

  test "updating a Simulation step" do
    visit simulation_steps_url
    click_on "Edit", match: :first

    fill_in "Description", with: @simulation_step.description
    fill_in "Name", with: @simulation_step.name
    fill_in "Simulation", with: @simulation_step.simulation_id
    fill_in "Sm type", with: @simulation_step.sm_type
    click_on "Update Simulation step"

    assert_text "Simulation step was successfully updated"
    click_on "Back"
  end

  test "destroying a Simulation step" do
    visit simulation_steps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Simulation step was successfully destroyed"
  end
end
