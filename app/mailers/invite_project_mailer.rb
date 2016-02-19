class InviteProjectMailer < ActionMailer::Base
  default from: "noreply@tms.com"

  def invite_member(user, project, collaboration, admin)
    @admin = admin
    @user = user
    @project = project
    @collaboration = collaboration
    @url = "#{$base_url}/projects/#{@project.id}/invitation/#{@collaboration.id}"
    mail(to: @user.email, subject: "Invitation to #{@project.name}")
  end
end