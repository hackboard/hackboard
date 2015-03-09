class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :name, :password_digest, null: false
      t.string :remember_digest, :current_sign_in_ip, :last_sign_in_ip
      t.integer :sign_in_count, null: false, default: 0
      t.timestamps null: false
    end
  end
end
