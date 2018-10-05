require 'rails_helper'
require 'pry'
RSpec.describe User, type: :model do
  context 'validation tests' do
    let(:user) { build(:random_user) } # User.new({})
    #let(:user) { create(:user) } # User.create({})
    it 'ensures last_name presence' do
      user.nom = nil
      expect(user.save).to eq(false)
    end
    it 'ensures first_name presence' do
      user.prenom = nil
      expect(user.save).to eq(false)
    end
  end

end
