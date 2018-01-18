class AddColumnsValuationBooleanToHousing < ActiveRecord::Migration[5.1]
  def change
    add_column :housings, :only_valuation, :boolean
  end
end
