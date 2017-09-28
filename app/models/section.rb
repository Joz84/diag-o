class Section < ApplicationRecord
  has_many :questions
  validates :name, presence: true, uniqueness: true, allow_blank: true
end
