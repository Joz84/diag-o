class AddCoordinatesToZones < ActiveRecord::Migration[5.1]
  def change
    add_column :zones, :latitude, :float
    add_column :zones, :longitude, :float
  end
end
