class Question < ApplicationRecord
  has_many :option_groups
  has_one :units
  has_many :sections

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :input_type, presence: true

end
