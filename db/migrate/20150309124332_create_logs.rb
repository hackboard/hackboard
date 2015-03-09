class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :name, :from, :to, :description, null: false
      t.references :user, null: false
      t.timestamps null: false
    end
  end
end
