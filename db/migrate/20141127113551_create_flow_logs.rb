class CreateFlowLogs < ActiveRecord::Migration
  def change
    create_table :flow_logs do |t|
      t.integer :flow_id
      t.timestamps
    end
  end
end
