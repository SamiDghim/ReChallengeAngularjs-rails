class CreateCongeDemandes < ActiveRecord::Migration[5.1]
  def change
    create_table :conge_demandes do |t|
      t.date :date_debut
      t.date :date_debut
      t.date :date_fin
      t.text :motifAb
      t.text :motifR
      t.string :etat , default:'pas encore traité'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
