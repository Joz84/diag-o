class ChangeColumnsHousing < ActiveRecord::Migration[5.1]
  def change
    rename_column :housings, :address, :geoloc
    rename_column :housings, :floors, :floor
    rename_column :housings, :surface_area, :surface
    rename_column :housings, :building_quality, :construction_quality
    rename_column :housings, :living_room_quality, :living_quality
    rename_column :housings, :bedroom_quality, :rooms_quality
    rename_column :housings, :parking, :parking_lot
    rename_column :housings, :cellar, :basement
    rename_column :housings, :house_keeper, :concierge
    rename_column :housings, :community_heating, :collective_heating
  end
end
