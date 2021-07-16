# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbApi::FetchMovieData do
  describe '#call' do
    subject { described_class.new(title: 'Star Wars').call }
  end

  # around { |example| VCR.use_cassette('omdb_movie', match_requests_on: %i[host method body], &example) }

  # it 'returns 200 status' do
  #   expect(subject.code).to eq(200)
  # end
end
