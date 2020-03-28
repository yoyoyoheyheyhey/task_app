class Admin::UsersController < ApplicationController
  skip_before_action :login_check
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.name}を作成しました！"
    else
      flash.now[:danger] = "#{@user.name}の作成に失敗しました！"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name}の情報を更新しました！"
    else
      flash.now[:danger] = "#{@user.name}の情報を更新できませんでした！"
      render :new
    end
  end

  def show
  end

  def index
      @users = User.sorted_by
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました！"
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                  :email,
                                  :admin,
                                  :password,
                                  :password_confirmation)
  end
  def set_params
    @user = User.find(params[:id])
  end
end
