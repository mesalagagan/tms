class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_task, only: [:edit, :update, :destroy]
  before_filter :get_project, only: [:new, :create]

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to user_project_path(current_user.id, @project.id), notice: 'Task Created Successfully'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to user_project_path(current_user.id, @task.project.id), notice: 'Task Updated Successfully'
    end
  end

  def destroy
    if @task
      @task.destroy
      redirect_to user_project_path(current_user.id, @task.project.id), notice: 'Task deleted successfully'
    end
  end

  def get_task
    @task = Task.find(params[:id])
  end

  def get_project
    @project = Project.find_by(id: params[:project_id])
  end

  protected

  def task_params
    params.require(:task).permit(:title, :description, :due_date)
  end
end