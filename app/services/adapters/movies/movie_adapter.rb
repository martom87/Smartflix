# frozen_string_literal: true

module Adapters
  module Movies
    class MovieAdapter

      def initialize(raw_movie_data)
        @raw_movie_data = raw_movie_data
      end

      def new_movie
        Movie.new(movie_data)
      end

      attr_reader :raw_movie_data

      private

      FORBIDDEN_KEYS = [:type].freeze
      KEYS_TO_RENAME = { imdbrating: :imdb_rating, imdbvotes: :imdb_votes, imdbid: :imdb_id,
                         boxoffice: :box_office }.freeze

      def movie_data
        rename_keys(parse_to_hash.transform_keys(&:downcase).symbolize_keys)
      end

      def parse_to_hash
        JSON.parse(raw_movie_data.response.body)
      end

      def rename_keys(data)
        [KEYS_TO_RENAME.keys, FORBIDDEN_KEYS].flatten.each do |key|
          next unless data.key?(key)

          rename_wrong_key_name(data, key)
        end
        data.delete(:response)
        data
      end

      def rename_wrong_key_name(data, key)
        FORBIDDEN_KEYS.include?(key) ? rename_forbidden_key(data, key) : improve_key_name(data, key)
      end

      def rename_forbidden_key(data, forbidden_key)
        data["movie_#{forbidden_key}".to_sym] = data.delete(forbidden_key)
      end

      def improve_key_name(data, key_to_rename)
        data[KEYS_TO_RENAME[key_to_rename]] = data.delete(key_to_rename)
      end

    end
  end
end
