class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :file_type
      t.string :filename
      t.string :server_name
      t.integer :user_id
      t.timestamps
    end
  end
end
