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
      movie.save
    rescue StandardError
      Rails.logger.warn("#{Time.current}: #{inputs[:title]} movie not found!")
    end

    def movie
      @movie = Adapters::Movies::MovieAdapter.new(movie_data).new_movie
    end

    def movie_data
      OmdbApi::FetchMovieData.new(title: inputs[:title]).call
    end

  end
end
