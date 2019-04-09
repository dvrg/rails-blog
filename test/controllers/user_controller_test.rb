require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:david)
    @other_user = users(:firdha)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: @other_user.password, password_confirmation: @other_user.password, admin: @other_user.admin}}
    assert_not @other_user.admin?
  end

  test "view links all users data" do
    log_in_as(@user) # login terlebih dahulu
    get users_path 
    assert_template 'users/index'
    #assert_select "a[href=?]"
  end

  test "should redirect destroy when not loggeed in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when looged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
