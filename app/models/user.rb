class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password_digest ,:on => :create
  has_many :boards
  has_many :tasks
  has_many :resources
  has_many :logs
  belongs_to :board_member

end
