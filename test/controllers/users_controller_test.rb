require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    post users_signup_url
    assert_response :success
  end

  test "should get login" do
    post users_login_url
    assert_response :success
  end
end
