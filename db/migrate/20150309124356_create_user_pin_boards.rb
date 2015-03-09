class CreateUserPinBoards < ActiveRecord::Migration
  def change
    create_table :user_pin_boards do |t|
      t.references :user, :board, null: false
      t.timestamps null: false
    end
  end
end
