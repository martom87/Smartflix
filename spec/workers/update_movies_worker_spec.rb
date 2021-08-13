# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMoviesWorker do
  describe '#perform' do
    subject { described_class.new.perform }

    let(:movie) { create(:movie, title: 'Star Wars') }

    it 'updates attributes of the movie attributes but does not the movies amount ' do
      VCR.use_cassette('correct_movie_example', match_requests_on: %i[host method body]) do
        expect do
          subject
          movie.reload
        end.to change(movie, :updated_at)
      end
    end
  end
end
