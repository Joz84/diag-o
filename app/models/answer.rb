class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :diagnostic
  has_many :option_choices


end
