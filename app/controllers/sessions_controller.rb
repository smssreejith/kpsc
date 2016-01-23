class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    @user.update_attribute(role: 'normal') unless @user.id == 1
      exams = ExamRank.where(:user_id => session[:user_id], :role => 'normal')
      exam_ids = []
      exams.each do |ex|
        exam_ids.push ex.exam_id
      end
      user = UserAnswer.where(:user_id => session[:guest_user_id], :role => 'guest').where.not(:exam_id => exam_ids)
      user.update_all(:user_id => session[:user_id], :role => 'normal') if user
      rank = ExamRank.where(:user_id => session[:guest_user_id], :role => 'guest').where.not(:exam_id => exam_ids)
      rank.update_all(:user_id => session[:user_id], :role => 'normal') if rank
      UserAnswer.delete_all(:user_id => session[:guest_user_id], :role => 'guest')
      ExamRank.delete_all(:user_id => session[:guest_user_id], :role => 'guest')
    session[:guest_user_id] = nil
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    session[:guest_user_id] = cookies.signed[:user_id]
    redirect_to root_url
  end
end
