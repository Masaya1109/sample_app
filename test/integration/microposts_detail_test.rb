require "test_helper"

class MicropostsDetailTest < ActionDispatch::IntegrationTest
  
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
  end

  test "micropost's detail display" do
    get micropost_path(@micropost)
    assert_template 'microposts/show'
    # assert_select 'div', text: @user.name
    # assert_select 'div>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @micropost.replies.paginate(page: 1).each do |reply|
      assert_match reply.content, response.body
    end
  end
end
