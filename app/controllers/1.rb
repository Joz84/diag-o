class PlansController < ApplicationController
  before_action params_diagnostic, only: [:create, :destroy]

  def create
    authorize @diagnostic
    @plan = Plan.new { plan_params }
    @plan.diagnostic_id = params[:query][:result]
    @diagnostic.save!
    redirect_to diagnostician_diagnostic_path(@diagnostic)
  end

  def detroy
    @diagnostic.plan = nil
    redirect_to diagnostician_diagnostic_path(@diagnostic)
  end

  private

  def plan_params
    params.require(:plan).permit(:plan)
  end

  def params_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
  end
end
