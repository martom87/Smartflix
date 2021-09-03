# frozen_string_literal: true

module SaveFetchedMovie
  class Action < ::Base::Subject

    def initialize(inputs:)
      @inputs = inputs
      @observers = []
      @message = ''
    end

    def call
      save_fetched_movie
      notify
      @observers.each { |o| detach(o) }
    end

    def attach(observer)
      @observers << observer
    end

    def detach(observer)
      @observers.delete(observer)
    end

    def notify
      @observers.each { |observer| observer.update(self) }
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

  end
end
