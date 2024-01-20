require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_match /Invalid email\/password combination/i, response.body
    assert_not flash.empty?
  end
end