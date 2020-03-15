class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: '登録が完了しました！'
    else
      flash.now[:danger] = '登録に失敗しました！'
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def confirm
  end

  private 
  def task_params
    params.require(:task).permit(:title, :content)
  end

  def set_params
    @task = Task.find(params[:id])
  end
end
