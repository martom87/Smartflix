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

    attr_reader :inputs, :movie

    def save_fetched_movie
      Movie.create(movie_attributes)
      "Movie #{inputs[:title]} was saved"
    rescue StandardError
      "#{movie_data['Error']} movie: #{inputs[:title]} cannot be saved"
    end

    def movie_attributes
      Adapters::Movies::MovieAdapter.new(movie_data).movie_attributes
    end

    def movie_data
      OmdbApi::FetchMovieData.new(title: inputs[:title]).call
    end

  end
end
