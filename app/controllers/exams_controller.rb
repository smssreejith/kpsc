class ExamsController < ApplicationController
  before_action :initialize_web
  def index
    @exams = Exam.order(id: :desc).paginate(:page => params[:page], :per_page => 5)
  end

  def new
  end

  def edit
  end

  def show
    @exam = Exam.find(params[:id])
  end

  def upload_data
    xlsx = Roo::Spreadsheet.open(params[:uploaded_file].path)
    Exam.create(:exam_type => xlsx.cell(2,1), :code => xlsx.cell(3,1), :name => xlsx.cell(4,1), :date => xlsx.cell(5,1))    
    values = []
    exam_id = Exam.last.id
    column = [:exam_id, :q_num, :one, :two, :three, :four]
    for i in 8..57
      values.push [exam_id, xlsx.cell(i,1).to_i, xlsx.cell(i,2), xlsx.cell(i,3), xlsx.cell(i,4), xlsx.cell(i,5)]
    end 
    for i in 60..109
      values.push [exam_id, xlsx.cell(i,1).to_i, xlsx.cell(i,2), xlsx.cell(i,3), xlsx.cell(i,4), xlsx.cell(i,5)]
    end
    Answer.import column, values
    redirect_to root_url
  end
  
  def booklet
    @book = params[:booklet]
    @exam = Exam.find(params[:exam_id])
    @user_answer = UserAnswer.new
  end

  def booklet_create
    exam_id = params[:exam_id]
    book = params[:booklet]
    col = [:user_id, :exam_id, :booklet, :q_num, :answer, :role]
    values = []
    role = current_user.role
    params[:q_num].each do |q_num, ans|    
      values.push [current_user.id, exam_id, book, q_num, ans[:answer], role]
    end
    UserAnswer.import col, values
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
    ExamRank.create(:user_id => current_user.id, :exam_id => exam_id, :total => @total_count, :correct => @correct_count, :wrong => @wrong_count, :mark => @mark, :role => current_user.role)
  end
end
