class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_many :boards
  has_many :tasks
  has_many :user_pin_boards
  has_many :pin_boards, through: :user_pin_boards, source: :board
  has_many :board_members
  has_many :participate_boards, through: :board_members, source: :board

  before_save {
    self.email = email.downcase
  }

  has_secure_password

  validates_presence_of :password_digest, on: :create

  def myBoards
    {
        :pin => self.pin_boards,
        :other => (self.boards << self.participate_boards) - self.pin_boards
    }
  end

  def getBoard(id)
    self.boards.find(id) || self.participate_boards.find(id)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_token).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
