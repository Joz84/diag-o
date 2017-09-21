class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show]

  def index
    @user = current_user
    if @user.diagnostician?
      @diagnostics = @user.diagnostics # car un seul diagnosticien pour l'instant
      @housings = Housing.all
    else
      @diagnostics = @user.housings.map { |housing| housing.bookings.first.diagnostic }
      @housings = @user.housings
    end
  end

  def show
    authorize @diagnostic
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
