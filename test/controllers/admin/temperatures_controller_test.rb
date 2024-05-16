require "test_helper"

class Admin::TemperaturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_temperatures_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_temperatures_edit_url
    assert_response :success
  end
end
