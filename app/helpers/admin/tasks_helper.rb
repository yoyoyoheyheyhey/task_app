module Admin::TasksHelper
  def which_action
    if action_name == "new" || action_name == "create"
      admin_tasks_path
    elsif action_name == "edit" || action_name == "update"
      admin_task_path(@task.id)
    end
  end
end
