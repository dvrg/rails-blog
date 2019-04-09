require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:david)
  end

  test "login with invalid information followed by logout" do
    get login_path # visit the login path
    post login_path, params: { session: { email: @user.email, password: 'password'}} # post to the sessions path with an invalid params hash
    assert is_logged_in?
    assert_redirected_to @user #to check the right redirect target and
    follow_redirect! # to actually visit the target page
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is delete.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

end
