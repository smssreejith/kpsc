class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    user = UserAnswer.where(:user_id => session[:guest_user_id], :role => 'guest')
    user.update_all(:user_id => session[:user_id], :role => 'normal') if user
    rank = ExamRank.where(:user_id => session[:guest_user_id], :role => 'guest')
    rank.update_all(:user_id => session[:user_id], :role => 'normal') if rank
    session[:guest_user_id] = nil
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    session[:guest_user_id] = cookies.signed[:user_id]
    redirect_to root_url
  end
end
