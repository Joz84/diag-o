class CreateDiagnostics < ActiveRecord::Migration[5.1]
  def change
    create_table :diagnostics do |t|

      t.timestamps
    end
  end
end
