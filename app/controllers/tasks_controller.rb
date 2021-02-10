class TasksController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :labels_find, only: [:index, :new, :edit, :create, :update]
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: '登録が完了しました！'
    else
      flash.now[:danger] = '登録に失敗しました！'
      render :new
    end
  end

  def index
    @labels = Label.all
    @tasks = current_user.tasks.filtered_by(*filter_params).page(params[:page])
  end

  def show
    @labels = @task.labels
  end

  def edit; end

  def update
    if current_user.tasks.find(@task.id).update(task_params)
      redirect_to tasks_path, notice: '更新に成功しました！'
    else
      flash.now[:danger] = '更新に失敗しました！'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: '削除しました！'
  end

  private 
  def task_params
  params.require(:task).permit(:title, 
                                  :content, 
                                  :end_date, 
                                  :status, 
                                  :priority,
                                  { label_ids: [] })
  end

  def set_params
    @task = Task.find(params[:id])
  end

  def labels_find
    @labels = Label.all.where(user_id: 0).order(updated_at: :desc)
    @private_labels = Label.where(user_id: current_user.id).order(updated_at: :desc)
  end

  def filter_params
    params.permit(
      :with_title,
      :with_status,
      :with_priority,
      :sorted_by,
      with_label_ids: [],
    ).delete_if{|key, value| value.blank? }.to_h
  end
end
