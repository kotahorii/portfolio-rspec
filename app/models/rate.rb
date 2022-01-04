class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
