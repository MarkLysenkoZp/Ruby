require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger', text: 'The form contains 4 errors.'
    assert_select 'ul' do
      assert_select 'li', count: 5
      assert_select 'li', text: "Name can't be blank"
      assert_select 'li', text: "Email is invalid" 
      assert_select 'li', text: "Email has already been taken"
      assert_select 'li', text: "Password can't be blank"
      assert_select 'li', text: "Password confirmation doesn't match Password"
      assert_select 'li', text: "Password is too short"
  end
end