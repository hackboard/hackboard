class Flow < ActiveRecord::Base
  has_many :tasks
  has_many :flows , ->{order(:order)}
  belongs_to :board

  def subFlows
    self.flows
  end

end
