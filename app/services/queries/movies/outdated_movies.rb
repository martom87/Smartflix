# frozen_string_literal: true

module Queries
  module Movies
    class OutdatedMovies

      def self.call(relation = Movie, up_to)
        relation.where('updated_at < ?', up_to)
      end

    end
  end
end
