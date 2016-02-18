class AddFieldsToCollaboration < ActiveRecord::Migration
  def change
    add_reference :collaborations, :project, index: true
    add_reference :collaborations, :user, index: true
    add_column :collaborations, :role, :string
  end
end
