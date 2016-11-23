require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      user = User.new(active: true, email: "email4", firstName: "firstName4", lastName: "lastName4", password_digest: "password4", username: "username4")
      post users_url, params: { user: { active: user.active, email: user.email, firstName: user.firstName, lastName: user.lastName, username: user.username, password: user.password_digest, password_confirmation: user.password_digest } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { active: @user.active, email: @user.email, firstName: @user.firstName, lastName: @user.lastName, password_digest: @user.password_digest, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
