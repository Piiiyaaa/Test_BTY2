require "test_helper"

class Profiles::FollowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profiles_followings_index_url
    assert_response :success
  end
end
