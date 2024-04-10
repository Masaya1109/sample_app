require "test_helper"

class RepliesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @micropost = microposts(:orange)
    @reply = replies(:apple)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Reply.count' do
      post micropost_replies_path(@micropost), params: { reply: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Reply.count' do
      delete micropost_reply_path(@micropost, @reply)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end
end
