class AttemptsController < ApplicationController
  before_action :initialize_web
  def index
    user_exam = ExamRank.select(:exam_id).distinct.where(:user_id => current_user.id, :role => current_user.role)
    @attempt_exams = Exam.where(:id => user_exam).paginate(:page => params[:page], :per_page => 5)
  end

  def show
  end
end
