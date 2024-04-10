require "test_helper"

class ReplyTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @micropost = microposts(:ants)
    @reply = @user.replies.build(content: "Coooool", micropost_id: @micropost.id)
  end

  test "should be valid" do
    assert @reply.valid?
  end
  
  test "user id should be present" do
    @reply.user_id = nil
    assert_not @reply.valid?
  end

  test "micropost id should be present" do
    @reply.micropost_id = nil
    assert_not @reply.valid?
  end
  
  test "content should be present" do
    @reply.content = "   "
    assert_not @reply.valid?
  end

  test "content should be at most 140 characters" do
    @reply.content = "a" * 141
    assert_not @reply.valid?
  end

  test "order should be most recent first" do
    assert_equal replies(:most_recent_reply), Reply.first
  end
end
