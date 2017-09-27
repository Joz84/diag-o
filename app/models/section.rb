class Section < ApplicationRecord
  belongs_to :questions

  validates :name, presence: true, uniqueness: true, allow_blank: true
end
