class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :filename, :filetype, :servername, null: false
      t.references :user, null: false
      t.timestamps null: false
    end
  end
end
