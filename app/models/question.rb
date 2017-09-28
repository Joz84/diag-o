class Question < ApplicationRecord
  belongs_to :section
  has_one :option_group
  has_many :answers

  validates :name, presence: true, uniqueness: true, allow_blank: false

  def choices
    id = self.id
    OptionChoice.all.where(option_group_id: id).map { |q| q.name}
  end
end
