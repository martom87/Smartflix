# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::MoviesController', type: :request do
  before do
    Movie.create(title: '123')
    User.create(name: 'Bill')
  end

  describe 'GET api/v1/movies' do
    it 'is protected content' do
      get '/api/v1/movies/123'
      expect(response.status).to eq 401
    end

    it 'is accessible' do
      get '/api/v1/movies/123', headers: { HTTP_ACCESS_TOKEN: User.first.token }
      expect(response.status).to eq 200
    end
  end
end
