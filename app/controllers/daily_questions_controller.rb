class DailyQuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @daily_questions = current_user.posts.includes(:daily_question, :user).map(&:daily_question).compact
  end

  def show
    @daily_question = DailyQuestion.includes(post: :user).find(params[:id])
  end
end
