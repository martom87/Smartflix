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
      get '/movies/123', headers: { HTTP_ACCESS_TOKEN: User.first.token }
      expect(response.status).to eq 200
    end

    it 'when correct access token is given but nonexistent title is provided' do
      get '/movies/non-existen-movie', headers: { HTTP_ACCESS_TOKEN: User.first.token }
      expect(response.status).to eq 404
    end
  end
end
