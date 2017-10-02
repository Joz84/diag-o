class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show, :edit]
  before_action :params_diagnostic, only: [:show, :edit]

  def index
    if @user.diagnostician?
      @diagnostics = policy_scope(Diagnostic)
      @diagnostics = @user.diagnostics # car un seul diagnosticien pour l'instant
      @housings = Housing.all
    else
      @diagnostics = @user.housings.map { |housing| housing.bookings.first.diagnostic }
      @housings = @user.housings
    end

  end

  def show
    authorize @diagnostic
    if params[:query]
      @plan_id = params[:query][:result]
    end
  end

  def new
  end

  def edit
    authorize @diagnostic
    @sections = Section.all
    @questions = Question.where
  end

  private

  def params_user
    @user = current_user
  end

  def params_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end
end
