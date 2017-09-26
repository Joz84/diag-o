class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.references :section, foreign_key: true
      t.string :information
      t.references :option_group, foreign_key: true
      t.integer :input_type
      t.string :slug
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
