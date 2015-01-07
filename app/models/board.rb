class Board < ActiveRecord::Base
  has_many :types
  has_many :flows , ->{where(:flow_id => nil , :status => nil)}
  belongs_to :user
  has_many :board_members
  has_many :users ,:through => :board_members
end
