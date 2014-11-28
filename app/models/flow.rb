class Flow < ActiveRecord::Base
  has_many :tasks
  has_many :flows
  belongs_to :board
end
