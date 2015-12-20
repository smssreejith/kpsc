class AttemptsController < ApplicationController
  before_action :initialize_web
  def index
    role = is_guest_user? ? 'guest' : 'normal'
    user_exam = UserAnswer.select(:exam_id).distinct.where(:user_id => current_user.id, :role => role)
    @attempt_exams = Exam.where(:id => user_exam).paginate(:page => params[:page], :per_page => 2)
  end

  def show
  end
end
