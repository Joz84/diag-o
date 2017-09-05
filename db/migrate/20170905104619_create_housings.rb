class CreateHousings < ActiveRecord::Migration[5.1]
  def change
    create_table :housings do |t|
      t.string :address

      t.timestamps
    end
  end
end
