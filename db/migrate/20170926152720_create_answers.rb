class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true
      t.references :option_choice, foreign_key: true
      t.references :diagnostic, foreign_key: true
      t.integer :numeric
      t.string :string
      t.boolean :boolean
      t.text :comment

      t.timestamps
    end
  end
end
