require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger', text: 'The form contains 4 errors.'
    assert_select 'ul' do
      assert_select 'li', count: 4
      assert_select 'li', text: "Name can't be blank"
      assert_select 'li', text: "Email is invalid"
      assert_select 'li', text: "Password can't be blank"
      assert_select 'li', text: "Password confirmation doesn't match Password"
    end
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_not flash[:success].empty?
  end
end