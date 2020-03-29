class Admin::TasksController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  def new
    user_hash = params.permit!.to_hash
    user_id = user_hash['format'].to_i
    user = User.find(user_id)
    @task = user.tasks.build
  end

  def create
    @task = Task.new(user_params)
    if @task.save
      redirect_to admin_user_path(@task.user_id), notice: "登録が完了しました！"
    else
      flash.now[:danger] = "登録に失敗しました！"
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(user_params)
      redirect_to admin_user_path(@task.user_id), notice: "更新が完了しました！"
    else
      flash.now[:danger] = "更新に失敗しました！"
      render :edit
    end
  end


  def show; end

  def destroy
    @task.destroy
    redirect_to admin_user_path(@task.user_id), notice: "削除しました!"
  end

  private

  def user_params
    params.require(:task).permit(:title,:content,:end_date,:status,:priority,:user_id)
  end

  def set_params
    @task = Task.find(params[:id])
  end
end
