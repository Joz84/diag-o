class CreateOptionChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :option_choices do |t|
      t.string :name
      t.references :option_group, foreign_key: true

      t.timestamps
    end
  end
end
