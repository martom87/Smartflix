# frozen_string_literal: true

module SaveFetchedMovie
  class Action

    def initialize(inputs:)
      @inputs = inputs
    end

    def call
      download_movie_data
    end

    private

    attr_reader :inputs

    def download_movie_data
      OmdbApi::FetchMovieData.new(title: inputs[:title]).call
    end
  end
end
