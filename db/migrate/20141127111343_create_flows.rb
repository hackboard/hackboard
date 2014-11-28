class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.integer :max_task
      t.integer :max_day
      t.string :name
      t.integer :order
      t.integer :board_id
      t.integer :flow_id

      t.timestamps
    end
  end
end
