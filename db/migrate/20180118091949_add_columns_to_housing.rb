class AddColumnsToHousing < ActiveRecord::Migration[5.1]
  def change
    add_column :housings, :floors, :integer
    add_column :housings, :rooms, :integer
    add_column :housings, :surface_area, :integer
    add_column :housings, :building_quality, :integer
    add_column :housings, :kitchen_quality, :integer
    add_column :housings, :bathroom_quality, :integer
    add_column :housings, :living_room_quality, :integer
    add_column :housings, :bedroom_quality, :integer
    add_column :housings, :parking, :boolean
    add_column :housings, :cellar, :boolean
    add_column :housings, :house_keeper, :boolean
    add_column :housings, :elevator, :boolean
    add_column :housings, :balcony, :boolean
    add_column :housings, :community_heating, :boolean
  end
end
