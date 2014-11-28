class Log < ActiveRecord::Base
  belongs_to :flow_log
  belongs_to :board_log
  belongs_to :task_log
end
