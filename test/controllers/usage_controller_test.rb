require "test_helper"

class UsageControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get usage_new_url
    assert_response :success
  end
end
