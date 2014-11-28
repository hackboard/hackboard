class BoardLog < ActiveRecord::Base
  has_one :log
  belongs_to :board
end
