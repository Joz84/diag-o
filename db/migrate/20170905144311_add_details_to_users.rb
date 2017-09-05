class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :firstname, :string
    add_column :users, :zone, :string
    add_column :users, :phonenumber, :string
  end
end
