class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :diagnostic
  has_one :option_choice

  def litteral_answer
    array = self.attributes.slice('string', 'boolean', 'numeric', 'option_choice_id')
    if array.compact.first[0] == 'option_choice_id'
      OptionChoice.find(array.compact.first[1]).name
    else
      array.compact.first[1].to_s
    end
  end

end


 # || "numeric" || "boolean" || "option_choice_id") && value == true
