class CreateTowns < ActiveRecord::Migration[5.1]
  def change
    create_table :towns do |t|
      t.string :zipcode
      t.string :name

      t.timestamps
    end
  end
end
