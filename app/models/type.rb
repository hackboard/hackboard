class Type < ActiveRecord::Base
  belongs_to :board
  belongs_to :task
end
