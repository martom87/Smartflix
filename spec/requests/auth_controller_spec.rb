# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth Controller', type: :request do
  describe 'GET /login' do
    let!(:user) { User.create(id: 'Stive') }

    it 'returns user’s access token' do
      post '/login', params: { id: user.id }
      expect(user.token).to be_present
      expect(JSON.parse(response.body)).to eq({ 'token' => user.token })
    end
  end
end
