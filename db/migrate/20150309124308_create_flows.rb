class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.string :name, null: false
      t.string :status
      t.integer :max_task, :max_day, :order, default: 0
      t.references :board, null: false
      t.references :flow
      t.timestamps null: false
    end
  end
end
