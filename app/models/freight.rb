class Freight < ApplicationRecord
  validates :state, :weight_min, :weight_max, :cost, presence: true

  def self.address_state(address)
    where(state: address['state'])
  end
end
