class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show]

  def index
    @user = current_user
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
    @diagnostic = Diagnostic.find(params[:id])
    authorize @diagnostic
  end

  def new
  end

  def edit
    @user = current_user
    @diagnostic = Diagnostic.find(params[:id])
    authorize @diagnostic
    @sections = Section.all
    @questions = Question.where
  end

  def update
  end

  private

  def params_user
    @user = current_user
  end
end
