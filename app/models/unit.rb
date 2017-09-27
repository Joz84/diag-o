class Unit < ApplicationRecord
  belongs_to :questions

  validates :name, presence: true
end
