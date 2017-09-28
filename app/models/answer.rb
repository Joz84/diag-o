class Answer < ApplicationRecord
  belongs_to :question, :diagnostic, :option_choice
  has_many :option_choices

end
