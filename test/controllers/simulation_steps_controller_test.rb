require "test_helper"

class SimulationStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @simulation_step = simulation_steps(:one)
  end

  test "should get index" do
    get simulation_steps_url
    assert_response :success
  end

  test "should get new" do
    get new_simulation_step_url
    assert_response :success
  end

  test "should create simulation_step" do
    assert_difference('SimulationStep.count') do
      post simulation_steps_url, params: { simulation_step: { description: @simulation_step.description, name: @simulation_step.name, simulation_id: @simulation_step.simulation_id, sm_type: @simulation_step.sm_type } }
    end

    assert_redirected_to simulation_step_url(SimulationStep.last)
  end

  test "should show simulation_step" do
    get simulation_step_url(@simulation_step)
    assert_response :success
  end

  test "should get edit" do
    get edit_simulation_step_url(@simulation_step)
    assert_response :success
  end

  test "should update simulation_step" do
    patch simulation_step_url(@simulation_step), params: { simulation_step: { description: @simulation_step.description, name: @simulation_step.name, simulation_id: @simulation_step.simulation_id, sm_type: @simulation_step.sm_type } }
    assert_redirected_to simulation_step_url(@simulation_step)
  end

  test "should destroy simulation_step" do
    assert_difference('SimulationStep.count', -1) do
      delete simulation_step_url(@simulation_step)
    end

    assert_redirected_to simulation_steps_url
  end
end
