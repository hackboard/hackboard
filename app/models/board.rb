class Board < ActiveRecord::Base
  has_many :types
  has_many :flows
  belongs_to :user
  has_many :users ,:through => :board_members
end
