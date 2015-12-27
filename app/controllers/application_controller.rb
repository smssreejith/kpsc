class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def initialize_web
    unless cookies.signed[:user_id]
       GuestUser.create
       cookies.permanent.signed[:user_id] = GuestUser.last.id
    end
    session[:guest_user_id] = cookies.signed[:user_id] unless is_logged_in?
    @q = Exam.order(id: :desc).search(params[:q])
    @exams = @q.result().paginate(:page => params[:page], :per_page => 5)
  end 
  private

  def current_user
    @current_user ||= session[:user_id] ? User.find_by(id: session[:user_id]) : GuestUser.find_by(id: session[:guest_user_id])
  end

  def is_logged_in?
    return true if session[:user_id]
  end
  def is_guest_user?
    return true if session[:guest_user_id]
  end
  helper_method :current_user, :is_logged_in?, :is_guest_user?

end
