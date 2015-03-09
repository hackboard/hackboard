class CreateBoardLogs < ActiveRecord::Migration
  def change
    create_table :board_logs do |t|
      t.references :board, null: false
      t.string :description, null: false
      t.timestamps null: false
    end
  end
end
