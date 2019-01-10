require 'rails_helper'

RSpec.describe Conge, type: :model do
  before :each do
    User.create(nom: 'med',prenom: 'aissa',email: 'med@yahoo.com',password: 'usermed')
    CongeDemande.create(user_id: 1,date_debut:'05/10/2018',date_fin:'10/10/2018',motifAb: 'test rspec')
  end
  it 'should persist a conge Demand' do
    expect(CongeDemande.count).to eq(3)
  end

 #Added by ayoub
  it "is valid with valid attributes" do
    conge = CongeDemande.create(user_id: 1,date_debut:'05/10/2018',date_fin:'10/10/2018',motifAb: 'test rspec')
    expect(conge).to be_valid
  end
  it "is not valid without a motif"  do
    congedemande = CongeDemande.new(motifAb: nil)
    expect(congedemande).to_not be_valid
  end

  it "is not valid without a start_date" do
    congedemande = CongeDemande.new(date_debut: nil)
    expect(congedemande).to_not be_valid
  end

  it "is not valid without a end_date" do
    congedemande = CongeDemande.new(date_fin: nil)
    expect(congedemande).to_not be_valid
  end

end
