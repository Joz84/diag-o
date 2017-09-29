class OptionGroup < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :option_choices
end
