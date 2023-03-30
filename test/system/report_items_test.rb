require "application_system_test_case"

class ReportItemsTest < ApplicationSystemTestCase
  setup do
    @report_item = report_items(:one)
  end

  test "visiting the index" do
    visit report_items_url
    assert_selector "h1", text: "Report Items"
  end

  test "creating a Report item" do
    visit report_items_url
    click_on "New Report Item"

    fill_in "Description", with: @report_item.description
    fill_in "Name", with: @report_item.name
    fill_in "Report", with: @report_item.report_id
    fill_in "Report type", with: @report_item.report_type
    click_on "Create Report item"

    assert_text "Report item was successfully created"
    click_on "Back"
  end

  test "updating a Report item" do
    visit report_items_url
    click_on "Edit", match: :first

    fill_in "Description", with: @report_item.description
    fill_in "Name", with: @report_item.name
    fill_in "Report", with: @report_item.report_id
    fill_in "Report type", with: @report_item.report_type
    click_on "Update Report item"

    assert_text "Report item was successfully updated"
    click_on "Back"
  end

  test "destroying a Report item" do
    visit report_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Report item was successfully destroyed"
  end
end
