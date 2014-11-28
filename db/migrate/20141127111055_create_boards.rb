class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :wip
      t.text :description
      t.integer :board_id
      t.integer :user_id
      t.timestamps
    end
  end
end
