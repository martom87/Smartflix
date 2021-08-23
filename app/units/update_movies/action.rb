# frozen_string_literal: true

module UpdateMovies
  class Action

    def call
      update_movies
    end

    private

    def update_movies
      movie_attributes = {}

      Movie.find_each(batch_size: 5) do |movie|
        movie_attributes = movie_attributes(movie.title)
        next if movie.attributes == movie_attributes

        movie.update(movie_attributes)
      end
    end

    def movie_attributes(title)
      movie_data = OmdbApi::FetchMovieData.new(title: title).call
      Adapters::Movies::MovieAdapter.new(movie_data).new_movie.attributes.compact
    end

  end
end
