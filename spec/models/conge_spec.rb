require 'rails_helper'
require 'pry'
RSpec.describe Conge, type: :model do
  before :each do
    User.create(nom: 'med',prenom: 'aissa',email: 'med@yahoo.com',password: 'usermed')
    CongeDemande.create(user_id: 1,date_debut:'05/10/2018',date_fin:'10/10/2018',motifAb: 'test rspec')
  end
  it 'should persist a conge Demand' do
    expect(CongeDemande.count).to eq(1)
  end
end
