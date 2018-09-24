class AddSoldeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :solde, :int
  end
end
