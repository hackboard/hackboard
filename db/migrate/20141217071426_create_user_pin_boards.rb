class CreateUserPinBoards < ActiveRecord::Migration
  def change
    create_table :user_pin_boards , :id => false do |t|
      t.belongs_to :user
      t.belongs_to :board
      t.timestamps
    end
  end
end
