class User < ActiveRecord::Base
   before_save {
     self.email = email.downcase
   }
  has_secure_password
  validates_presence_of :password_digest ,:on => :create
  has_many :boards
  has_many :tasks
  has_many :resources
  has_many :logs
  has_many :user_pin_boards
  has_many :pin_boards , through: :user_pin_boards , source: :board
  belongs_to :board_member

end
