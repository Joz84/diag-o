class CreateUserHousings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_housings do |t|
      t.references :user, foreign_key: true
      t.references :housing, foreign_key: true
      t.integer :user_state

      t.timestamps
    end
  end
end
