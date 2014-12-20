require 'test_helper'
class UserControllerTest < ActionController::TestCase


  def setup
    @controller = Api::UserController.new
  end

  def teardown
    session.delete :login_user
  end

  def test_login_success

    # post(:login,{:email=>'alice@meigic.tw',:password=>'alice0000'})
    # assert_equal(nil,@response.body)
    # assert_response(200)
  end

  def test_login_failed
    post(:login,{:email=>'XXXXX@meigic.tw',:password=>'XXXXX0000'})
    assert_equal("UMSE02",@response.body)
    assert_response(403)
  end
  def test_logout_failed
    post(:logout)
    assert_equal("UMSE05",@response.body)
  end


  def test_logout_success
    session[:login_user] = 'alice@megic.tw'
    post(:logout)
    assert_equal("success",@response.body)
  end

  def test_logout_200
    post(:logout)
    assert_response(200)
  end
end
