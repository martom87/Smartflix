# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies Controller', type: :request do
  before do
    Movie.create(title: '123')
    User.create(name: 'Bill')
  end

  describe 'GET /movies' do
    it 'is protected content' do
      get '/movies/123'
      expect(response.status).to eq 401
    end

    it 'is accessible' do
      get '/movies/123', headers: { access_token: User.first.token }
      expect(response.status).to eq 200
    end
  end
end
