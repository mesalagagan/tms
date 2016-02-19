class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_project, only: [:edit, :update, :destroy, :show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.collaborations.build(:user_id => current_user.id, project_id: @project.id, :role => 'Admin')
    if @project.save
      redirect_to dashboard_path, notice: 'Project created successfully'
    end
  end

  def edit
  end

  def update
    @project.update(project_params)
    redirect_to dashboard_path, notice: 'Project updated successfully'
  end

  def destroy
    if @project
      @project.destroy
      redirect_to dashboard_path, notice: 'Project deleted successfully'
    end
  end

  def show
    if @project
      @tasks = @project.tasks
      puts @tasks.inspect
    end
  end

  def project_params
    params.require(:project).permit(:name, :project_image, :submission_date)
  end

  def get_project
    @project = Project.find(params[:id])
  end

end
