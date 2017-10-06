class AddPlanToDiagnostic < ActiveRecord::Migration[5.1]
  def change
    add_column :diagnostics, :plan, :integer
  end
end
