class Answer < ApplicationRecord
  belongs_to :question_id
  belongs_to :question_choice_id
  belongs_to :diag_id
end
