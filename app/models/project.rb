class Project < ActiveRecord::Base
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations

  mount_uploader :project_image, ProjectImageUploader


  def is_admin(user_id, project_id)
    collaboration = Collaboration.find_by(user_id: user_id, project_id: project_id)
    if collaboration.role == "Admin"
      true
    else
      false
    end
  end
end
