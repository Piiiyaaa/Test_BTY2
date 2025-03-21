require "test_helper"

class DailyQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get daily_questions_show_url
    assert_response :success
  end
end
