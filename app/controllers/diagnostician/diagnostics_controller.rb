class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show, :edit]
  before_action :params_diagnostic, only: [:show, :edit, :add_plan, :delete_plan]

  def index
    @diagnostics = policy_scope(Diagnostic)
    @diagnostics = @user.diagnostics # car un seul diagnosticien pour l'instant
    @housings = Housing.all
  end

  def show
    @sections = Section.all
    authorize @diagnostic
    @booking = @diagnostic.booking
    @markersPosition = [[@booking.housing.latitude, @booking.housing.longitude]]
    draw_marker(@booking.housing)
    if params[:query]
      @plan_id = params[:query][:address]
    end
  end

  def edit
    authorize @diagnostic
    @booking = @diagnostic.booking
    draw_marker(@booking.housing)
    @sections = Section.all
  end

  def add_plan
    authorize @diagnostic
    @diagnostic.plan = params[:query][:address]
    @diagnostic.save!
    redirect_to diagnostician_diagnostic_path(@diagnostic)
  end

  def delete_plan
    authorize @diagnostic
    @diagnostic.plan = nil
    @diagnostic.save!
    redirect_to diagnostician_diagnostic_path(@diagnostic)
  end

  private

  def params_user
    @user = current_user
  end

  def params_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end
end
