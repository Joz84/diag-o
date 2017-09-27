class OptionGroup < ApplicationRecord
  belongs_to :question
  belongs_to :option_choice

  validates :name, presence: true, uniqueness: true
end
