class SessionsController < ApplicationController
  skip_before_action :login_check
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: 'ログインに成功しました！'
    else
      flash.now[:danger] = 'ログインに失敗しました！'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path,notice: 'ログアウトしました！'
  end
end
