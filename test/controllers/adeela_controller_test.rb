require 'test_helper'

class AdeelaControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get adeela_show_url
    assert_response :success
  end

end
