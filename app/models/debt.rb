class Debt < ActiveRecord::Base

  belongs_to :unit
  belongs_to :debt_type
  belongs_to :notice

end
