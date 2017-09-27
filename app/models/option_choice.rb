class OptionChoice < ApplicationRecord
  belongs_to :option_group_id

  validates :name, presence: true, uniqueness: true, allow_blank: true
end
