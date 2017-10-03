class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show]
  before_action :params_diagnostic, only: [:show, :edit]

  def index
    @diagnostics = policy_scope(Diagnostic)
    @diagnostics = @user.diagnostics # car un seul diagnosticien pour l'instant
    @housings = Housing.all
  end

  def show
    @sections = Section.all
    authorize @diagnostic
  end

  def edit
    @sections = Section.all
    authorize @diagnostic
  end

  private

  def params_user
    @user = current_user
  end

  def params_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end
end
