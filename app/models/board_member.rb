class BoardMember < ActiveRecord::Base
  has_many :users
  belongs_to :board
end
