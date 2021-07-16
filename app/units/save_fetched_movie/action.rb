# frozen_string_literal: true

module SaveFetchedMovie
  class Action

    def initialize(inputs:)
      @inputs = inputs
    end

    def call
      save_fetched_movie
    end

    private

    attr_reader :inputs

    def save_fetched_movie
      Adapters::Movies::MovieAdapter.new(download_raw_movie_data).new_movie.save
    rescue StandardError
      "#{download_raw_movie_data['Error']} movie: #{inputs[:title]} cannot be saved"
    end

    def download_raw_movie_data
      OmdbApi::FetchMovieData.new(title: inputs[:title]).call
    end

  end
end
