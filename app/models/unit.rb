class Unit < ActiveRecord::Base

  belongs_to :owner
  belongs_to :condominium

  has_many :debts

end
