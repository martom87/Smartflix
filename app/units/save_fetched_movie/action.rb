# frozen_string_literal: true

module SaveFetchedMovie
  class Action

    include ::Base::Subject

    def initialize(inputs:)
      @inputs = inputs
      super
    end

    def call
      save_fetched_movie
      notify
    end

    attr_reader :message

    private

    attr_reader :inputs

    def save_fetched_movie
      movie.save
    rescue StandardError
      @message = "#{Time.current}: #{inputs[:title]} movie not found!"
      Rails.logger.warn(message)
    end

    def movie
      @movie = Adapters::Movies::MovieAdapter.new(movie_data).new_movie
    end

    def movie_data
      OmdbApi::FetchMovieData.new(title: inputs[:title]).call
    end

    def notify
      @observers.each { |observer| observer.update(self) }
    end

  end
end
