require "test_helper"

class ArtitsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artits_show_url
    assert_response :success
  end
end
