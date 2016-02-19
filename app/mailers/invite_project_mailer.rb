class InviteProjectMailer < ActionMailer::Base
  default from: "noreply@tms.com"

  def invite_member(user, project, admin)
    @admin = admin
    @user = user
    @project = project
    mail(to: @user.email, subject: "Invitation to #{@project.name}")
  end
end