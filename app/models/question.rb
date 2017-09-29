class Question < ApplicationRecord
  belongs_to :section
  belongs_to :option_group
  has_many :answers
  enum input_type: {option_choice_id: 0, numeric: 1, string: 2, boolean: 3}
  delegate :option_choices, to: :option_group
  validates :name, presence: true, uniqueness: true, allow_blank: false

  def current_answer_for(diag_id)
    unless self.nil?
      answer = Answer.where(question: self, diagnostic_id: diag_id).last
    # unless answer.nil?
      # answer.string? ? answer.string : OptionChoice.find(answer.option_choice_id).name
    end
  end

end
