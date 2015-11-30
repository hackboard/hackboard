class CreateFlowLogs < ActiveRecord::Migration
  def change
    create_table :flow_logs do |t|
      t.references :flow, null: false
      t.string :description, null: false
      t.timestamps null: false
    end
  end
end
