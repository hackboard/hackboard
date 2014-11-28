class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.integer :task_id
      t.timestamps
    end
  end
end
