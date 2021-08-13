# frozen_string_literal: true

module RemoveOutdatedMovies
  class Action

    def call
      outdated_movies = Queries::Movies::OutdatedMovies.call(48.hours.ago)
      outdated_movies.destroy_all
    end

  end
end
