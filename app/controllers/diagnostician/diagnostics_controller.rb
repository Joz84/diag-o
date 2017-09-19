class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show]

  def index
    @diagnostics = Diagnostic.all # car un seul diagnosticien pour l'instant
    @housings = Housing.all
  end

  def show
    @diagnostic = Diagnostic.find(params[:id])
  end

  def new
  end

  def edit
  end

  def update

  end

  private

  def params_user
    @user = current_user
  end
end
