class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :zones, :colore, :color
  end
end
