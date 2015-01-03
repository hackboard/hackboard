require 'test_helper'

class BoardsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::BoardsController.new
  end

  def teardown
  end

  #-- index --
  test "test_index_success" do
    session[:login_user] = "bob@meigic.tw"
    get(:index)
    assert_equal("{\"pin\":[],\"other\":[{\"id\":1,\"name\":\"work1\",\"wip\":10,\"description\":\"Board1\",\"board_id\":null,\"user_id\":1,\"created_at\":\"2014-12-22T16:16:46.000Z\",\"updated_at\":\"2014-12-22T16:16:46.000Z\"}]}",@response.body)

  end

  test "test_index_DAPIE01" do
    get(:index)
    assert_equal("\"DAPIE01\"",@response.body)
    assert_response(403)
  end

  #-- create --
  test "test_create_success" do
    
  end

  test "test_create_DAPIE02_forbidden" do

  end

  #-- destory --
  test "test_destory_DAPIE03" do

  end

  test "test_destory_delete success" do

  end

  test "test_destory_Not login" do

  end
  #-- flows --
  test "test_flows_DAPIE04" do

  end

  test "test_flows_Not login" do

  end
end