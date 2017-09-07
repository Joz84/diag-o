class AddColumnsToPoint < ActiveRecord::Migration[5.1]
  def change
    add_column :points, :lng, :string
    add_column :points, :lat, :string
  end
end
