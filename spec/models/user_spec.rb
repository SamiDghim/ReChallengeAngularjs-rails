require 'rails_helper'
RSpec.describe User, type: :model do
  context 'validation tests' do
      # User.new({})
      let(:user) { build(:random_user) }

    it 'ensures last_name presence' do
      user.nom = nil
      expect(user.save).to eq(false)
    end
    it 'ensures first_name presence' do
      user.prenom = nil
      expect(user.save).to eq(false)
    end
    it 'ensures the password >= 6' do
      user.password = "0000000"
      expect(user.password.length).to be >= 6
    end
  end

end
