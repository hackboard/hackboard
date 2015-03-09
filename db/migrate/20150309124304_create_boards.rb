class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.integer :wip, default: 0
      t.text :description
      t.references :board
      t.references :user, null: false
      t.timestamps null: false
    end
  end
end
