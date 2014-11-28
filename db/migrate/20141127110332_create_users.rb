class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email ,null: false, default: ""
      t.string :name ,null: false, default: ""
      t.string :password_digest
      t.integer :sign_in_count , default: 0, null: false
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.timestamps
    end
  end
end
