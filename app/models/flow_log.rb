class FlowLog < ActiveRecord::Base
  has_one :log
  belongs_to :flow
end
