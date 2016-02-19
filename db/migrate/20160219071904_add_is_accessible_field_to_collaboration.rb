class AddIsAccessibleFieldToCollaboration < ActiveRecord::Migration
  def change
    add_column :collaborations, :isaccessible, :boolean
  end
end
