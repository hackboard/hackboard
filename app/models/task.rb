class Task < ActiveRecord::Base
  has_one :type
  belongs_to :flow
  belongs_to :user
end
