class Diagnostician::DiagnosticsController < ApplicationController
  before_action :params_user, only: [:index, :show, :edit]
  before_action :params_diagnostic, only: [:show, :edit, :add_plan, :delete_plan]

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
    @sections = Section.all
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
  end

  def add_plan
    authorize @diagnostic
    @diagnostic.plan = params[:query][:result]
    @diagnostic.save!
    redirect_to diagnostician_diagnostic_path(@diagnostic)
  end

  def delete_plan
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
