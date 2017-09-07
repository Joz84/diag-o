class CreateZones < ActiveRecord::Migration[5.1]
  def change
    create_table :zones do |t|
      t.references :town, foreign_key: true
      t.string :colore

      t.timestamps
    end
  end
end
