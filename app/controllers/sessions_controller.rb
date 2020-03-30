class SessionsController < ApplicationController
  skip_before_action :login_check
  before_action :logged_in_check, only: [:new]

  def new; end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_users_path, notice: "管理者としてログインしました！"
      else
        redirect_to tasks_path, notice: 'ログインに成功しました！'
      end
    else
      flash.now[:danger] = 'ログインに失敗しました！'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path,notice: 'ログアウトしました！'
  end

  private
  def logged_in_check
    redirect_to tasks_path if current_user.present?
  end
end
