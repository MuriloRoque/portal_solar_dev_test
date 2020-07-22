class Freight < ApplicationRecord
  validates :state, :weight_min, :weight_max, :cost, presence: true
end
