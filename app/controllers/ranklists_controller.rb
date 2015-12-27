class RanklistsController < ApplicationController
  before_action :initialize_web
  def index
  	@user_exams = ExamRank.where(:user_id => current_user.id, :role => 'normal').order(id: :desc).paginate(:page => params[:page], :per_page => 4)
  	@exam_ids =[]
  	@user_exams.each do |val|
  		@exam_ids.push val.exam_id
    end
    @ranks = ExamRank.where(:exam_id => @exam_ids, :role => 'normal')
  end

  def show
  	@exam_ids =[params[:id]]
    @ranks = ExamRank.where(:exam_id => params[:id], :role => 'normal')
  end
end
