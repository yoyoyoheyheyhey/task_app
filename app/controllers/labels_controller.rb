class LabelsController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :labels_faind, only: [:new, :edit, :create, :update]

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      redirect_to new_label_path, notice: "登録に成功しました！"
    else
      flash.now[:danger] = "登録に失敗しました！"
      render :new
    end
  end

  def edit; end

  def update
    if @label.update(label_params)
      redirect_to new_label_path, notice: "更新に成功しました！"
    else
      flash.now[:danger] = "更新に失敗しました！"
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to new_label_path, flash: {danger: '削除しました！'} 
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end

  def set_params
    @label = Label.find(params[:id])
  end

  def labels_faind
    @labels = Label.all.where(user_id: current_user.id).page(params[:page])
  end

end
