# frozen_string_literal: true

module OmdbApi
  class FetchMovieData < Base

    def initialize(title:)
      super()
      @title = title
    end

    def call
      self.class.get('&t', query: { t: title })
    end

    private

    attr_reader :title

  end
end
