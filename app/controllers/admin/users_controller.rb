class Admin::UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :admin_user_check
  before_action :current_user_delete_check, only: [:destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "#{@user.name}を作成しました！"
    else
      flash.now[:danger] = "ユーザーの作成に失敗しました！"
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
    @tasks = Task.with_user_id(params[:id])
                 .with_title(params[:title])
                 .with_status(params[:status])
                 .sorted_by(params[:sort_option]).page(params[:page])
  end

  def index
      @users = User.sorted_by
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました！"
    else
      flash[:danger] = "管理者を全て削除することができません！"
      redirect_to admin_users_path
    end
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

  def admin_user_check
    redirect_to new_user_path, flash: {danger: "あなたは管理者ではありません!"} unless current_user.admin?
  end

  def current_user_delete_check
      redirect_to admin_users_path, flash:{ danger: "自身を削除することはできません！" }  if current_user.id == params[:id].to_i
  end

end
