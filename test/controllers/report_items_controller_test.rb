require "test_helper"

class ReportItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report_item = report_items(:one)
  end

  test "should get index" do
    get report_items_url
    assert_response :success
  end

  test "should get new" do
    get new_report_item_url
    assert_response :success
  end

  test "should create report_item" do
    assert_difference('ReportItem.count') do
      post report_items_url, params: { report_item: { description: @report_item.description, name: @report_item.name, report_id: @report_item.report_id, report_type: @report_item.report_type } }
    end

    assert_redirected_to report_item_url(ReportItem.last)
  end

  test "should show report_item" do
    get report_item_url(@report_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_item_url(@report_item)
    assert_response :success
  end

  test "should update report_item" do
    patch report_item_url(@report_item), params: { report_item: { description: @report_item.description, name: @report_item.name, report_id: @report_item.report_id, report_type: @report_item.report_type } }
    assert_redirected_to report_item_url(@report_item)
  end

  test "should destroy report_item" do
    assert_difference('ReportItem.count', -1) do
      delete report_item_url(@report_item)
    end

    assert_redirected_to report_items_url
  end
end
