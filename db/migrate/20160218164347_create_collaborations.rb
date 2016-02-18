class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|

      t.timestamps
    end
  end
end
