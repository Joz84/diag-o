class OptionChoice < ApplicationRecord
  belongs_to :option_group

  validates :name, presence: true
end
