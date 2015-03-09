class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.references :task, null: false
      t.string :description, null: false
      t.timestamps null: false
    end
  end
end
