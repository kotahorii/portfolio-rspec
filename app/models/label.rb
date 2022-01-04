class Label < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :name, presence: true
end
