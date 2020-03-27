class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: 'ログインに成功しました！'
    else
      flash.now[:danger] = 'ログインに失敗しましt！'
      render 'users/new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_user_path,notice: 'ログアウトしました！'
  end
end
