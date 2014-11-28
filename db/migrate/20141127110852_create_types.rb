class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.string :color
      t.integer :board_id
      t.timestamps
    end
  end
end
