class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      redirect_to users_path, notice: "ユーザーの新規登録が完了しました！"
    else
      flash.now[:danger] = "登録に失敗しました！"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to tasks_path, notice: 'ユーザー情報を更新しました！'
    else
      flash.now[:danger] = '更新に失敗しました！'
      render :edit
    end
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def set_params
    @user = User.find(params[:id])
  end
end
