require "test_helper"

class MicropostsInterface < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
    @micropost = microposts(:orange)
  end
end

class MicropostsInterfaceTest < MicropostsInterface

end
