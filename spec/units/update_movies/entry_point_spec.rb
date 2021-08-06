# frozen_string_literal: true

require 'rails_helper'

describe UpdateMovies::EntryPoint do
  subject { described_class.new.call }

  let(:movie) { create(:movie, title: 'Star Wars') }

  context 'when movie attributes were changed' do
    it 'updates attributes of the movie attributes but does not the movies amount ' do
      VCR.use_cassette('correct_movie_example', match_requests_on: %i[host method body]) do
        expect do
          subject
          movie.reload
        end.to change(movie, :imdb_votes).to(1).and(change(movie, :director).to('George Lucas'))
      end
      expect { subject }.to change(Movie, :count).by(0)
    end
  end

  context 'when movie attributes were not changed' do
    let(:movie) { create(:movie, title: 'Star Wars', director: 'George Lucas') }

    it 'updates attributes of the movie attributes but does not the movies amount ' do
      VCR.use_cassette('correct_movie_example', match_requests_on: %i[host method body]) do
        expect do
          subject
          movie.reload
        end.not_to change(movie, :director)
      end
      expect { subject }.to change(Movie, :count).by(0)
    end
  end
end
