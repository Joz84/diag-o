class Question < ApplicationRecord
  belongs_to :section
  has_one :option_group
  has_many :answers

  validates :name, presence: true, uniqueness: true, allow_blank: false

  def choices_names
    id = self.id
    OptionChoice.all.where(option_group_id: id).map { |q| q.name}
  end

  def choices
    id = self.id
    OptionChoice.all.where(option_group_id: id)
  end

  def current_answer
    Answer.all.where(question: self)
  end
end
