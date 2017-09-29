class AnswersController < ApplicationController
  after_action :verify_authorized, except: [:create, :update]


  def create
    @diagnostic = Diagnostic.find(params[:answer][:diagnostic_id])
    @answer = Answer.create(answer_params)
      if @answer.save!
        redirect_to edit_diagnostician_diagnostic_path(@diagnostic)
      else
        raise
      end
  end

  def update

  end

  private

  def answer_params
    params.require(:answer).permit(:diagnostic_id, :string, :question_id, :option_choice_id)
  end

end
