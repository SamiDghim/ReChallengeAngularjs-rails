class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nom, :string
    add_column :users, :prenom, :string
  end
end
