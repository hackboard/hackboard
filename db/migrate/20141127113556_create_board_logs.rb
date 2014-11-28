class CreateBoardLogs < ActiveRecord::Migration
  def change
    create_table :board_logs do |t|
      t.integer :board_id
      t.timestamps
    end
  end
end
