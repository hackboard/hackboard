class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :state
      t.text :description
      t.integer :order, default: 0
      t.references :flow, null: false
      t.references :user, :type
      t.timestamps null: false
    end
  end
end
