class TaskLog < ActiveRecord::Base
  has_one :log
  belongs_to :task
end
