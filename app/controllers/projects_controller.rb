class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.collaborations.build(:user_id => current_user.id, project_id: @project.id, :role => 'Admin')
    @project.save
    redirect_to dashboard_path, notice: 'Project created successfully'
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to dashboard_path, notice: 'Project updated successfully'
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to dashboard_path, notice: 'Project deleted successfully'
  end

  def project_params
    params.require(:project).permit(:name, :project_image, :submission_date)
  end

end
