require "test_helper"

class TimeFlowMonitorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_flow_monitor = time_flow_monitors(:one)
  end

  test "should get index" do
    get time_flow_monitors_url
    assert_response :success
  end

  test "should get new" do
    get new_time_flow_monitor_url
    assert_response :success
  end

  test "should create time_flow_monitor" do
    assert_difference('TimeFlowMonitor.count') do
      post time_flow_monitors_url, params: { time_flow_monitor: { description: @time_flow_monitor.description, name: @time_flow_monitor.name, project_id: @time_flow_monitor.project_id } }
    end

    assert_redirected_to time_flow_monitor_url(TimeFlowMonitor.last)
  end

  test "should show time_flow_monitor" do
    get time_flow_monitor_url(@time_flow_monitor)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_flow_monitor_url(@time_flow_monitor)
    assert_response :success
  end

  test "should update time_flow_monitor" do
    patch time_flow_monitor_url(@time_flow_monitor), params: { time_flow_monitor: { description: @time_flow_monitor.description, name: @time_flow_monitor.name, project_id: @time_flow_monitor.project_id } }
    assert_redirected_to time_flow_monitor_url(@time_flow_monitor)
  end

  test "should destroy time_flow_monitor" do
    assert_difference('TimeFlowMonitor.count', -1) do
      delete time_flow_monitor_url(@time_flow_monitor)
    end

    assert_redirected_to time_flow_monitors_url
  end
end
