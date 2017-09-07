class AddIdzoneToZone < ActiveRecord::Migration[5.1]
  def change
    add_column :zones, :id_zone, :string
  end
end
