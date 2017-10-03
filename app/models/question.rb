class Question < ApplicationRecord
  belongs_to :section
  belongs_to :option_group
  has_many :answers
  enum input_type: {option_choice_id: 0, numeric: 1, string: 2, boolean: 3}
  delegate :option_choices, to: :option_group
  validates :name, presence: true, uniqueness: true, allow_blank: false

  def answer_is(diag)
    self.answers.where(diagnostic: diag).first
  end

  def has_answer?(diag)
    self.answers.where(diagnostic: diag).first.attributes.slice('string', 'boolean', 'numeric', 'option_choice_id').compact.any?
  end

end
