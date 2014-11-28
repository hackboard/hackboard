class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :state
      t.string :name
      t.integer :order
      t.text :description
      t.integer :user_id
      t.integer :flow_id
      t.integer :type_id
      t.timestamps
    end
  end
end
