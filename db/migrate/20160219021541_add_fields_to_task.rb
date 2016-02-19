class AddFieldsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :title, :string
    add_column :tasks, :description, :text
    add_column :tasks, :due_date, :date
  end
end
