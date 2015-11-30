class CreateBoardMembers < ActiveRecord::Migration
  def change
    create_table :board_members do |t|
      t.references :board, :user, null: false
      t.integer :permission, null: false, default: 0
      t.timestamps null: false
    end
  end
end
