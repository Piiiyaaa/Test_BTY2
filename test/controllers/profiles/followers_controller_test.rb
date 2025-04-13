require "test_helper"

class Profiles::FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profiles_followers_index_url
    assert_response :success
  end
end
