class Board < ActiveRecord::Base
  has_many :flows
  has_many :board_members
  has_many :users, through: :board_members
  belongs_to :user
end
