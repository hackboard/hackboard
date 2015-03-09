class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name, :color, null: false
      t.references :board, null: false
      t.timestamps null: false
    end
  end
end
