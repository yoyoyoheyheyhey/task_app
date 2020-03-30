class UsersController < ApplicationController
  skip_before_action :login_check, only:[:new,:create]
  before_action :user_page_check, only: [:show]
  before_action :new_user_page_check, only: [:new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "新規登録が完了しました！"
    else
      flash.now[:danger] = "登録に失敗しました！"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def user_page_check
     redirect_to tasks_path unless current_user.id == params[:id].to_i
  end

  def new_user_page_check
     redirect_to tasks_path if logged_in?
  end
end
