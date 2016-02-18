class AddFieldsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :name, :string
    add_column :projects, :project_image, :string
    add_column :projects, :submission_date, :date
  end
end
