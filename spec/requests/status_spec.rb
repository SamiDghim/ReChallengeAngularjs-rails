require 'rails_helper'
require 'pry'

RSpec.describe 'Status requests' do
  describe 'GET /GetAllUsers/(/:p)' do
    it 'returns a status message' do
      get ('/GetAllUsers')
      json = JSON.parse(response.body)
      expect(json['status']).to eql('SUCCESS')
    end
  end
end
