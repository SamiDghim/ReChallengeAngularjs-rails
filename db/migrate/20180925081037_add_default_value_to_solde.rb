class AddDefaultValueToSolde < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :solde, :int, default: 20
  end
end
