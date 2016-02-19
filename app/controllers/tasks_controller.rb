class TasksController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.find_by(id: params[:project_id])
    @task = @project.tasks.new
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to  user_project_path(current_user.id, @project.id), notice: 'Task Created Successfully'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to  user_project_path(current_user.id, @task.project.id), notice: 'Task Updated Successfully'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task
      @task.destroy
      redirect_to user_project_path(current_user.id, @task.project.id), notice: 'Project deleted successfully'
    end
  end

  def task_params
    params.require(:task).permit(:title, :description,:due_date)
  end
end