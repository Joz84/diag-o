class OptionGroup < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
