class ExamsController < ApplicationController
  before_action :initialize_web

  def index
    @q = Exam.order(id: :desc).search(params[:q])
    @exams = @q.result().paginate(:page => params[:page], :per_page => 5) 
  # @exams = Exam.order(id: :desc).paginate(:page => params[:page], :per_page => 5)
  end

  def new
  end

  def edit
    @exam = Exam.find(params[:id])
    @user_answers = UserAnswer.where(:exam_id => params[:id], :user_id => current_user.id)
  end

  def show
    @exam = Exam.find(params[:id])
  end
  
  def booklet
    @book = params[:booklet]
    @exam = Exam.find(params[:exam_id])
    @user_answer = UserAnswer.new
  end

  def exam_result
    exam_id = params[:exam_id]
    @exam = Exam.find(params[:exam_id])
    book = params[:booklet]
    col = [:user_id, :exam_id, :booklet, :q_num, :answer, :role]
    values = []
    role = current_user.role
    params[:q_num].each do |q_num, ans|    
      values.push [current_user.id, exam_id, book, q_num, ans[:answer], role]
    end
    UserAnswer.import col, values, :on_duplicate_key_update => [:answer]
    @total_count = 0
    @correct_count = 0
    @wrong_count = 0
   UserAnswer.where(:exam_id => exam_id).each do |check|
     case book
      when "A"
        booklet = Answer.where(:exam_id => exam_id, :q_num => check.q_num).where.not(:one => "X").first.one
      when "B"
        booklet = Answer.where(:exam_id => exam_id, :q_num => check.q_num).where.not(:two => "X").first.two
      when "C"
        booklet = Answer.where(:exam_id => exam_id, :q_num => check.q_num).where.not(:three => "X").first.three
      when "D"
        booklet = Answer.where(:exam_id => exam_id, :q_num => check.q_num).where.not(:four => "X").first.four
    end
      
      booklet == check.answer ? @correct_count += 1 : @wrong_count +=1
      @total_count += 1
    end
    @cancelled_count = @total_count - (@correct_count + @wrong_count)
    @mark = (@correct_count - (@wrong_count.to_f/3)).round(2)
    rank_col = [:user_id, :exam_id, :total, :correct, :wrong, :mark, :role]
    rank_val = [[current_user.id, exam_id, @total_count, @correct_count, @wrong_count, @mark, current_user.role]]
    ExamRank.import rank_col, rank_val, :on_duplicate_key_update => [:total, :correct, :wrong, :mark]
  end
end
