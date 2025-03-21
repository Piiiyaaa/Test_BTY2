class DailyQuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @daily_questions = DailyQuestion.includes(post: :user).order(created_at: :desc)
  end

  def show
    @daily_question = DailyQuestion.includes(post: :user).find(params[:id])
  end
end
