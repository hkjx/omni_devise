require 'test_helper'

class AuthorizationControllerTest < ActionController::TestCase
  test "should get vkontakte" do
    get :vkontakte
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
