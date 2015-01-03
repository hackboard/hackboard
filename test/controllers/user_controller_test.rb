require 'test_helper'
class UserControllerTest < ActionController::TestCase


  def setup
    @controller = Api::UserController.new
  end

  def teardown
    session.delete :login_user
  end

  #-- register --
  test "test_register_UMSE04" do
    post :register,{email:"tom@meigic.tw",password:"Tom0000",password_confirmation:"Tom0000.",name:"Tom"}
    assert_equal("\"UMSE04\"",@response.body)
  end

  test "test_register_success" do
    post :register,{email:"tom@meigic.tw",password:"Tom0000",password_confirmation:"Tom0000",name:"Tom"}
    assert_equal("\"success\"",@response.body)
    assert_response(200)
  end

  test "test_register_UMSE03" do
    post :register,{email:"alice@meigic.tw",password:"Alice0000",password_confirmation:"Alice0000",name:"Alice"}
    assert_equal("\"UMSE03\"",@response.body)
    assert_response(403)
  end
  #-- login --
  test "test_login_success" do
     post :login,{email:"alice@meigic.tw",password:"Alice0000"}
     assert_equal("\"success\"",@response.body)
     assert_response(200)
  end

  test "test_login_UMSE02" do
    post(:login,{email:'XXXXX@meigic.tw',password:'XXXXX0000'})
    assert_equal("\"UMSE02\"",@response.body)
    assert_response(403)
  end

  test "test_login_UMSE01" do
    post(:login,{email:"alice@meigic.tw",password:"Alice000"})
    assert_equal("\"UMSE01\"",@response.body)
  end

  #-- logout --
  test "test_logout_UMSE05" do
    post(:logout)
    assert_equal("\"UMSE05\"",@response.body)
  end


  test "test_logout_success" do
    session[:login_user] = 'alice@megic.tw'
    post(:logout)
    assert_equal("\"success\"",@response.body)
  end

  test "test_logout_200" do
    post(:logout)
    assert_response(200)
  end
end
