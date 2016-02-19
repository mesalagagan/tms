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

  def invitation
    @collaboration = Collaboration.find(params[:id])
    @collaboration.update(is_accessible: true)
    redirect_to dashboard_path, notice: 'Successfully added collaborator to project'
  end

  def invite
    @user = User.new
    @users = User.all.where.not(email: current_user.email)
    @project_id = params[:project_id]
    # @collaborations = Collaboration.where(project_id: params[:project_id])
    @collaborations = Collaboration.where(project_id: params[:project_id], isaccessible: true)
    @collaborators = []
    @collaborations.each do |c|
      @collaborators << User.find_by(id: c.user_id)
    end
  end

  def invited
    @user = User.find_by(email: params[:user][:email])
    @project = Project.find(params[:project_id])
    if @user
      if !Collaboration.find_by(user_id: @user.id, project_id: @project.id)
        @collaboration = Collaboration.create(project_id: @project.id, user_id: @user.id, role: 'Member', isaccessible: false)
        InviteProjectMailer.invite_member(@user, @project, current_user).deliver!
        redirect_to dashboard_path, notice: 'Invitation sent successfully'
      else
        redirect_to dashboard_path, notice: 'This member has already access to project'
      end
    end
  end

  def project_params
    params.require(:project).permit(:name, :project_image, :submission_date)
  end

  def get_project
    @project = Project.find(params[:id])
  end

end
