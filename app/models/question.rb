class Question < ApplicationRecord
  belongs_to :option_group_id
  belongs_to :unit_id
end
