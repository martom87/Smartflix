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
    rescue StandardError
      Rails.logger.warn("#{Time.current}: #{inputs[:title]} movie not found!")
    end

    def movie_attributes
      Adapters::Movies::MovieAdapter.new(movie_data).movie_attributes
    end

    def movie_data
      OmdbApi::FetchMovieData.new(title: inputs[:title]).call
    end

  end
end
